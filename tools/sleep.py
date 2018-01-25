import subprocess
from rofi import Rofi
import datetime

def notify(title, body):
    subprocess.call(f'notify-send "{title}" "{body}"', shell=True)

def main():
    r = Rofi()
    r.lines = 3
    r.width = 300
    options = ['sleeping now', 'know time going to sleep', 'know time waking up']
    index, key = r.select('> ', options)
    if index == 0:
        now = datetime.datetime.now() + datetime.timedelta(minutes=90*2) + datetime.timedelta(minutes=15)
        possibilities = []
        for i in range(5):
            now += datetime.timedelta(minutes=90)
            possibilities.append('%d:%02d' % (now.hour, now.minute))
        possibilities = '\n'.join(possibilities)
        notify('Wake up times', possibilities)
    # elif index == 1:
    #     sleeptime = r.text_entry('Enter time of sleep:')
    #     sleephour, sleepminute = sleeptime.split(":")
    #     print(sleephour, sleepminute)
    # elif index == 2:
    #     pass
    # else:
    #     return

def simple():
    now = datetime.datetime.now() + datetime.timedelta(minutes=90*2) + datetime.timedelta(minutes=15)
    possibilities = []
    for i in range(5):
        now += datetime.timedelta(minutes=90)
        possibilities.append('%d:%02d' % (now.hour, now.minute))
    possibilities = '\n'.join(possibilities)
    notify('Wake up times', possibilities)

if __name__ == "__main__":
    simple()
