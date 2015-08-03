# Engima

## Base Expectations

You are to build an encryption engine for encrypting, decrypting, and cracking
messages.

### Encryption Notes

The encryption is based on rotation. The character map is made up of all the
lowercase letters, then the numbers, then space, then period, then comma. New
lines will not appear in the message nor character map.

#### The Key

* Each message uses a unique encryption key
* The key is five digits, like 41521
* The first two digits of the key are the "A" rotation (41)
* The second and third digits of the key are the "B" rotation (15)
* The third and fourth digits of the key are the "C" rotation (52)
* The fourth and fifth digits of the key are the "D" rotation (21)

#### The Offsets

* The date of message transmission is also factored into the encryption
* Consider the date in the format DDMMYY, like 020315
* Square the numeric form (412699225) and find the last four digits (9225)
* The first digit is the "A offset" (9)
* The second digit is the "B offset" (2)
* The third digit is the "C offset" (2)
* The fourth digit is the "D offset" (5)

#### Encrypting a Message

* Four characters are encrypted at a time.
* The first character is rotated forward by the "A" rotation plus the "A offset"
* The second character is rotated forward by the "B" rotation plus the "B offset"
* The third character is rotated forward by the "C" rotation plus the "C offset"
* The fourth character is rotated forward by the "D" rotation plus the "D offset"

#### Decrypting a Message

The offsets and keys can be calculated by the same methods above. Then each character
is rotated backwards instead of forwards.

#### Cracking a Key

When the key is not known, the offsets can still be calculated from the message
date. We believe that each enemy message ends with the characters `"..end.."`. Use
that to calculate your key.

### Usage

The tool is used from the command line like so:

```
$ ruby ./lib/encrypt.rb message.txt encrypted.txt
Created 'encrypted.txt' with the key 82648 and date 030415
```

That will take the plaintext file `message.txt` and create an encrypted file `encrypted.txt`.

Then, if we know the key, we can decrypt:

```
$ ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 030415
Created 'decrypted.txt' with the key 82648 and date 030415
```

But if we don't know the key, we can try to crack it with just the date:

```
$ ruby ./lib/crack.rb encrypted.txt cracked.txt 030415
Created 'cracked.txt' with the cracked key 82648 and date 030415
```
From [Turing School Engima Project](https://github.com/turingschool/curriculum/blob/master/source/projects/enigma.markdown)
