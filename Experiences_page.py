import stream
from random import randint
import _datetime
import MongoCalls

client = stream.connect('6mrsygzpr525', 's64tas6unkczm5a6dj5qr4w8dgrpgqe2gdy8f8t9cp68ctbezp2fc7exepmkh5ka')
hannah_feed = client.feed('user', 'Hannah')


# add all experiences in mongodb to getstream temporary method
# def add_experiences_from_mongo():
#     experiences = MongoCalls.get_experience()
#     for experience in experiences:
#         hannah_feed.add_activity({'id': experience['_id'], 'actor': experience['userid'], 'tweet': experience['solution'],
#                                     'verb': 'tweet', 'object': 1, 'date': _datetime.datetime.utcnow()})
class user:
    def __init__(self, username):
        self.name = username
        self.feed = client.feed('user', username)
        self.id = randint(0, 9999)

    def add_experience(self, value, verb):
        self.feed.add_activity({'actor': self.name, 'tweet': value, 'verb': verb, 'foreignid': self.id,
                                'date':_datetime.datetime.utcnow()})

    def get_feed(self):
        feed = self.feed.get()
        return feed['results']

    def follows(self, fuser):
        self.feed.follow('user', fuser)

    def unfollows(self, fuser):
        self.feed.unfollow('user', fuser)



def add_experience(value):
    hannah_feed.add_activity({'actor': 'Hannah', 'tweet': value, 'verb': 'tweet', 'object': 1})


def get_experience():
    j_result = dict
    feed = hannah_feed.get()
    print(feed['results'])
    for result in feed['results']:
        result['votes'] = MongoCalls.get_ex_votes(result['foreign_id'])
    return feed['results']




if __name__ =='__main__':
    #add_experiences_from_mongo()
    get_experience()