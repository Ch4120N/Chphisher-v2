import hashlib
import time


def createLogMD5():
    str2hash = time.strftime("%Y-%m-%d-%H:%M", time.gmtime())
    result = hashlib.md5(str2hash.encode()).hexdigest()
    return result
