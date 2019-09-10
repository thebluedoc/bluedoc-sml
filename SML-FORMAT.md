**SML** 文档格式是 BlueDoc 自己的自定义文档存储格式，我们通过 [JsonML](http://www.jsonml.org) 的结构来存储文档的数据，内部有各种各样 BlueDoc 自己特有的一套对于格式的描述。

目前 SML 分别支持 JavaScript、Ruby 来解析，并最终转换为 HTML、PlainText、Markdown ... 任何格式。

Ruby 实现地址:

* [https://github.com/thebluedoc/bluedoc-sml](https://github.com/thebluedoc/bluedoc-sml)

## 格式描述

整个文档由类似数组的方式描述，数组分为 3 个部分：

```
["type", { attributes ...  }, child, child, child ...]
```

#### 第 1 段是 `String` 类型，值描述了当前这段内容的类型：

* root - 根节点
* p - 段落
* list - UL/OL 列表
* blockquote - 引用
* codeblock - 代码段落
* h1, h2, h3, h4, h5, h6 - Heading
* image - 图片
* file - 附件
* video - 视频
* 更多详见: [rules 实现的内容[](https://github.com/thebluedoc/bluedoc-sml/tree/master/lib/bluedoc/sml/rules)](https://github.com/thebluedoc/bluedoc-sml/tree/master/lib/bluedoc/sml/rules)

#### 第 2 段为属性

属性不是简单的 HTML Attributes，里面包含 BlueDoc SML 的自定义格式描述，例如 `{ align: "center" }`

> 假如没有属性，第 2 段可以省略，也就是说最少可以有两个部分组成如：`["p", "Hello world"]`


#### 第 3 段...第 N 段，为多个子集的描述：

> 如果没有属性，将从第 2 段开始


* 它们可以是 `String` 表示简单的文本内容；
* 也可以继续是一个 SML 结构，表示 Nested HTML 结构，例如 `["p", {}, ["image", {}, ""]]` 这样表示在 `p > img` 的层级关系，层级支持无限往下。
* 当然，后面也可以是多个 SML 结构，例如 `["p", {}, ["image", {}], ["image", {}] ... ]` 后面多个 image 表示同一级的多个 HTML 节点，XPath 类似: `p > img + img + img` 。

## 简单例子

下面是一个段落（居中对齐），内容为 “Hello world” 的例子

```
["p", { align: "center", indent: 1 }, "Hello world"]
```
