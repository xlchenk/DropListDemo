# DropListDemo
下拉列表的小demo  代码不多 比较简单

######CGRectInset 的使用方法:
```
使用方法：

//初始化方法  frame: 控件的frame ,这里是默认为是按钮的frame   用的其他控件时可根据需要修改内部代码
            arrData:下拉列表的展示内容
              （str:NSString）-> () :闭包，回调点击到的内容
let dropList = DropListView(frame:button.frame, arrData: ["1","2","3","4","5"]) { (str:NSString) in
print(str)
}
//tabWidth:下拉列表的宽度 默认是140
dropList.tabWidth = 150
//列表的偏移位置。 默认是0  即中间位置
dropList.tabOffset = 80
//弹出下拉列表
dropList.showList()



```
