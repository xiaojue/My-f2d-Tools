
YUI Compressor v2.4.2


安装指南
=========

安装步骤：

1. 安装请点击 install.cmd
2. 卸载请点击 uninstall.cmd
3. 如果安装过之前的版本，请先卸载老版本


压缩测试：

选中 test.js, 执行右键菜单“Process with &YUICompressor”，会生成 test-min.js.

注意事项：

1. 需要安装 JDK >= 1.4, 并设置环境变量 JAVA_HOME
2. css 和 js 文件编码必须是 GB2312, GBK 或 GB18030. 如果要支持 UTF-8, 请在 compressor.cmd 中将 GB18030 替换为 UTF-8
3. css 文件中含有中文时，如果 css 编码和页面编码不一致，需要手动将中文替换为\xxxx, 详细说明请参考 compressor.cmd 中的说明
4. 如果不需要 native2ascii, 可以只安装 JRE （需要手动修改下 compressor.cmd）

Ref: 

1. Introducing the YUI Compressor: http://www.julienlecomte.net/blog/2007/08/11/
2. YUILibrary: http://yuilibrary.com/projects/yuicompressor/wiki
3. Documentation: http://developer.yahoo.com/yui/compressor/
4. native2ascii.exe: http://java.sun.com/j2se/1.4.2/docs/tooldocs/windows/native2ascii.html


历史更新
=========
2009-11-10  yubo    归入 OurTools, 细节优化
2009-02-12	yubo	1. yuicompressor升级到2.4.2
					2. 重写了compressor.cmd, 添加了比较详细的注释
					3. 改变了在注册表的中的注册方式，以避免与css和js的默认编辑器引起冲突
					4. 右键菜单项中，添加C作为快速选择键
					5. 压缩后，检查taobao.net并警告
2008-10-22	yubo	yuicompressor升级到2.4
2008-05-23	yubo	将reg更改为inf, 改进安装方式；改进cmd的显示和提示信息


版权声明
=========
所有版权归 YUI 所有

