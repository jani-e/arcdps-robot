import datetime

def datetime_to_timestamp(data):
    element = datetime.datetime.strptime(data,"%Y-%m-%d %H:%M")
    return datetime.datetime.timestamp(element)