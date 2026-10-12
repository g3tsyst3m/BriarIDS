#!/usr/bin/env python
import hashlib, httplib, mimetypes, os, pprint, simplejson, sys, urlparse

DEFAULT_TYPE = 'application/octet-stream'

REPORT_URL = 'https://www.virustotal.com/api/get_file_report.json'
SCAN_URL = 'https://www.virustotal.com/api/scan_file.json'

capturedkey = open('/opt/suricata/etc/suricata/Vtotalapi.key', 'r').read()
API_KEY = capturedkey.rstrip()
#print API_KEY

# The following function is modified from the snippet at:
# http://code.activestate.com/recipes/146306/
def encode_multipart_formdata(fields, files=()):
    """
    fields is a dictionary of name to value for regular form fields.
    files is a sequence of (name, filename, value) elements for data to be
    uploaded as files.
    Return (content_type, body) ready for httplib.HTTP instance
    """
    BOUNDARY = '----------ThIs_Is_tHe_bouNdaRY_$'
    CRLF = '\r\n'
    L = []
    for key, value in fields.items():
        L.append('--' + BOUNDARY)
        L.append('Content-Disposition: form-data; name="%s"' % key)
        L.append('')
        L.append(value)
    for (key, filename, value) in files:
        L.append('--' + BOUNDARY)
        L.append('Content-Disposition: form-data; name="%s"; filename="%s"' %
                 (key, filename))
        content_type = mimetypes.guess_type(filename)[0] or DEFAULT_TYPE
        L.append('Content-Type: %s' % content_type)
        L.append('')
        L.append(value)
    L.append('--' + BOUNDARY + '--')
    L.append('')
    body = CRLF.join(L)
    content_type = 'multipart/form-data; boundary=%s' % BOUNDARY
    return content_type, body

def post_multipart(url, fields, files=()):
    """
    url is the full to send the post request to.
    fields is a dictionary of name to value for regular form fields.
    files is a sequence of (name, filename, value) elements for data to be
    uploaded as files.
    Return body of http response.
    """
    content_type, data = encode_multipart_formdata(fields, files)
    url_parts = urlparse.urlparse(url)
    if url_parts.scheme == 'http':
        h = httplib.HTTPConnection(url_parts.netloc)
    elif url_parts.scheme == 'https':
        h = httplib.HTTPSConnection(url_parts.netloc)
    else:
        raise Exception('Unsupported URL scheme')
    path = urlparse.urlunparse(('', '') + url_parts[2:])
    h.request('POST', path, data, {'content-type':content_type})
    return h.getresponse().read()

def scan_file(filename):
    files = [('file', filename, open(filename, 'rb').read())]
    json = post_multipart(SCAN_URL, {'key':API_KEY}, files)
    return simplejson.loads(json)

def get_report(filename):
    md5sum = hashlib.md5(open(filename, 'rb').read()).hexdigest()
    json = post_multipart(REPORT_URL, {'resource':md5sum, 'key':API_KEY})
    data = simplejson.loads(json)
    if data['result'] != 1:
        print 'Result not found, submitting file.'
        data = scan_file(filename)
        if data['result'] == 1:
            print 'Submit successful.'
            print 'Please wait a few minutes and try again to receive report.'
        else:
            print 'Submit failed.'
            pprint.pprint(data)
    else:
        pprint.pprint(data['report'])


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print 'Usage: %s filename' % sys.argv[0]
        sys.exit(1)

    filename = sys.argv[1]
    if not os.path.isfile(filename):
        print '%s is not a valid file' % filename
        sys.exit(1)

    get_report(filename)

