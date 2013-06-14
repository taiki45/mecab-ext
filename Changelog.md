### 1.0.2 / 2013-06-15
[full changelog](http://github.com/taiki45/mecab-ext/compare/v1.0.2...master)

Enhancements

* Support Rails 4.0 (Naoyoshi Aikawa / @awakia)

### 1.0.1 / 2013-05-19
[full changelog](http://github.com/taiki45/mecab-ext/compare/v1.0.1...master)

Bug fixes

* While MeCab::Node instance is living and in use, a Tagger which generates these nodes should not be deleted because it causes inner inconsistency. When the tagger is deleted, its corresponding inner data seem to be also deleted, then trying to access to node's data causes SEGV. (osak a.k.a @osa_k)
