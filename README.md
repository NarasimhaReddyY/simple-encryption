# README

1. Compress Text
	
```
 POST https://encrypt-hackthon.herokuapp.com/api/v1/encryptions/convert
 {
 	input_string: 'aaaabbcccccdde',
 	mode: 'compress'
 }
```

2. Decompress Text

```
 POST https://encrypt-hackthon.herokuapp.com/api/v1/encryptions/convert
 {
 	input_string: '4a2b5c2de',
 	mode: 'decompress'
 }
```

3. Encrypt Text

```
 POST https://encrypt-hackthon.herokuapp.com/api/v1/encryptions/start
 {
 	input_string: 'abcdef',
 	key: 1
 	mode: 'bcdefg'
 }
```


3. Decrypt Text

```
 POST https://encrypt-hackthon.herokuapp.com/api/v1/encryptions/start
 {
 	input_string: 'klm0',
 	key: 10
 	mode: 'abc0'
 }
```