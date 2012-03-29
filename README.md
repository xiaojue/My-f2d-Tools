###cssbuild.py
rebuild the css file or directory.
```python
python cssbuild.py test.css test-min.css --build
``` 
All the @import files will build in test-min.css
```python
python cssbuild.py test.css test-min.css --compress
```
It will be compress the test.css to test-min.css

```python
python cssbuild.py test/ test-min/ --build
python cssbuild.py test/ test-min/ --compress
```

Supported directory

###dependent
    java 1.6.0 +
    python 2.7
