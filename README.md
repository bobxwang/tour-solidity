##### 关键字
- pure：纯牛马，不能读取也不能写入状态变量，调用不需要付gas，称视图函数
- view：看客，能读取但不能写入状态变量，调用不需要付gas
- payable：修饰的函数表示可以接受以太币，如果未指定，该函数将自动拒绝所有发送给它的以太币
- constant：常量类型，不占用合约存储空间，编译时会使用对应表达式值替换变量名
- immutable：不可变量，在构造函数是赋值，同样不占用变量存储空间
- external：外部，只能被其他合约调用，但可以用 ```this.f()``` f是函数名，不能修饰状态变量
- internal：只能从合约内部访问，继承的合约也可以，相当于 ```protected```，默认修饰类
##### 函数修改器
- modifier
##### 三个数据位置
- storage：存储在区块链上，需要gas
- memory：存储在堆上，不需要gas
- calldata：存储在栈上，不需要gas，与memory类似，但只读
##### ABI && Function Selector
-
##### 数字签名
- ECDSA，椭圆曲线数字签名算法
##### 事件
> 是虚拟机上日志的抽象，具备两个特点
>
> 响应：应用程序可通过RPC接口订阅监听这些事件并在UI上做出响应
>
> 经济：事件是虚拟机上比较经济的存储数据方式，每个大概消耗2000个Gas，相比存储一个变量至少要20000个Gas而言

```solidity
event Transfer(address indexed from, address indexed to, uint256 value);
```
##### 异常
- revert： 抛出异常，方便且高效，省Gas，是0.8.4之后新加的内容
- require：要求条件为真，否则抛出异常。其缺点是gas消耗随着描述异常的字符串长度增长而增大，比error命令要高，场景如检查用户输入值
- assert：消耗Gas次之，用于函数内部逻辑错误
```solidity
error TransferNotOwner(address sender);
function transfer(uint256 tokenId, address newOwner) public {
    if (_owners[tokenId] != msg.sender) {
        revert TransferNotOwner(msg.sender);
    }
    _owners[tokenId] = newOwner;
}
```
##### 接收ETH
> 一个合约最多有一个receive函数，同样最多也只能有一个fallback，对合约做任意函数调用若失败都会回退到fallback这个函数
- receive函数，不能有任何参数也不能有任何返回，必须包含external跟payable关键字，不能太复杂，复杂会触发out of gas
- fallback函数，在调用合约不存在的函数时触发，同样也可用于接收ETH
```solidity
event Received(address indexed sender, uint256 value);
receive() external payable {
    emit Received(msg.sender, msg.value);
}
fallback() external payable { }
```
> 合约接收ETH时，msg.data为空且存在receive()时，会触发receive()；msg.data不为空或不存在receive()时，会触发fallback()，此时fallback()必须为payable。
##### 发送ETH
- transfer：如果转账失败，会自动revert，有Gas限制，次选择
- send：如果转账失败，不会revert，函数返回值是布尔型，自己需要额外判断下是否成功，有Gas限制，一般没有人选择这种方式转
- call：如果转账失败，不会revert，返回值是(bool,data)，无Gas限制，最优选择
##### 合约调用其它合约
- call
- staticcall
- delegatecall，代理合约的时候一般会用到，还有一个是钻石？提供了一定灵活性，但要确保当前合约跟目标合约状态变量存储结构一致，否则会出问题。允许合约A调用合约B的代码却在A的上下文中执行

##### ERC721
> BTC/ETH这类属于同质化代币，其第一枚跟后面挖出来的没啥区别，是等价的。但世界上很多物品是不同的，比如房产/古董，这类物品无法用同质化代币抽象，因此以太坊EIP721提出了ERC721标准来抽象非同质化的物品，基于这个ERC721标准可发行NFT，在ERC721中，每个代币都有一个tokenId作为唯一标识，每个tokenId只对应一个代币
> 
> 如果一个合约没有实现ERC721标准，转入的NFT就进了黑洞，永远转不出来了，为防止误转账，目标合约还必须实现IERC721Receiver接口，否则会revert
##### ECDSA
> ECDSA是双椭圆曲线“私钥-公钥”对的数字签名算法
##### ERC1155
> 不论是ERC20还是ERC721标准，每个合约都对应一个独立的代币。而ERC1155是一个多代币标准，允许一个合约包含多个同质化和非同质化代币。
##### WETH
> WETH是ETH的带包装版本，以太币本身并不符合ERC20标准，WETH的开发是为了提高区块链间的互操作性，并使ETH可用于dApps，比普通ERC20多两个功能，存款跟取款
##### 线性释放
> 线性释放是ERC20代币的常见特性，ERC20代币的线性释放是指代币的发行量按照一定的速率线性释放，随着时间的推移，代币的发行量会逐渐增加，直到达到最大值。类似初创公司给员工的期权
##### 透明代理/通用可升级代理
> 解决代理中函数选择器冲突问题
> 
> 透明代理的逻辑简单，通过限制管理员调用逻辑合约解决“选择器冲突”问题。它也有缺点，每次用户调用函数时，都会多一步是否为管理员的检查，消耗更多gas。但瑕不掩瑜，透明代理仍是大多数项目方选择的方案
> 
> 通用可升级代理将升级函数放在逻辑合约中，这样一来如有其它函数跟升级函数存在选择器冲突就会编译失败
##### 多签钱包
> 一种电子钱包，特点是交易被多个私钥持有者（多签人）授权后才能执行：例如钱包由3个多签人管理，每笔交易需要至少2人签名授权。
