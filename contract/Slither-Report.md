**THIS CHECKLIST IS NOT COMPLETE**. Use `--show-ignored-findings` to show all the results.
Summary
 - [incorrect-exp](#incorrect-exp) (1 results) (High)
 - [divide-before-multiply](#divide-before-multiply) (8 results) (Medium)
 - [shadowing-local](#shadowing-local) (2 results) (Low)
 - [reentrancy-benign](#reentrancy-benign) (2 results) (Low)
 - [reentrancy-events](#reentrancy-events) (1 results) (Low)
 - [assembly](#assembly) (3 results) (Informational)
 - [pragma](#pragma) (1 results) (Informational)
 - [dead-code](#dead-code) (35 results) (Informational)
 - [solc-version](#solc-version) (13 results) (Informational)
## incorrect-exp
Impact: High
Confidence: Medium
 - [ ] ID-0
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) has bitwise-xor operator ^ instead of the exponentiation operator **: 
	 - [inverse = (3 * denominator) ^ 2](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L184)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


## divide-before-multiply
Impact: Medium
Confidence: Medium
 - [ ] ID-1
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L190)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-2
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L193)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-3
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L188)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-4
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse = (3 * denominator) ^ 2](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L184)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-5
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [prod0 = prod0 / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L172)
	- [result = prod0 * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L199)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-6
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L192)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-7
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L191)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-8
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) performs a multiplication on the result of a division:
	- [denominator = denominator / twos](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L169)
	- [inverse *= 2 - denominator * inverse](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L189)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


## shadowing-local
Impact: Low
Confidence: High
 - [ ] ID-9
[ItemBlocks.createPassport(uint256,string,string,string,string,string).name](src/ItemBlocks.sol#L36) shadows:
	- [ERC721.name()](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L74-L76) (function)
	- [IERC721Metadata.name()](lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#L16) (function)

src/ItemBlocks.sol#L36


 - [ ] ID-10
[ItemBlocks.updatePassport(uint256,string,string,string,string,string).name](src/ItemBlocks.sol#L42) shadows:
	- [ERC721.name()](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L74-L76) (function)
	- [IERC721Metadata.name()](lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#L16) (function)

src/ItemBlocks.sol#L42


## reentrancy-benign
Impact: Low
Confidence: Medium
 - [ ] ID-11
Reentrancy in [ItemBlocks.createPassport(uint256,string,string,string,string,string)](src/ItemBlocks.sol#L36-L40):
	External calls:
	- [_safeMint(msg.sender,tokenId)](src/ItemBlocks.sol#L37)
		- [retval = IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L467-L480)
	State variables written after the call(s):
	- [setCreator(msg.sender,tokenId)](src/ItemBlocks.sol#L38)
		- [allItemOwners[tokenId].push(creatorAddress)](src/ItemBlocks.sol#L76)
	- [setCreator(msg.sender,tokenId)](src/ItemBlocks.sol#L38)
		- [createdItems[creatorAddress].push(tokenId)](src/ItemBlocks.sol#L77)
	- [updatePassport(tokenId,name,desc,family,url,img)](src/ItemBlocks.sol#L39)
		- [itemPassports[tokenId] = Passport({name:name,desc:desc,family:family,url:url,img:img})](src/ItemBlocks.sol#L45-L51)

src/ItemBlocks.sol#L36-L40


 - [ ] ID-12
Reentrancy in [ItemBlocks.updateOwnership(address,address,uint256)](src/ItemBlocks.sol#L88-L92):
	External calls:
	- [safeTransferFrom(currentOwnerAddress,nextOwnerAddress,tokenId)](src/ItemBlocks.sol#L90)
		- [retval = IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L467-L480)
	State variables written after the call(s):
	- [allItemOwners[tokenId].push(nextOwnerAddress)](src/ItemBlocks.sol#L91)

src/ItemBlocks.sol#L88-L92


## reentrancy-events
Impact: Low
Confidence: Medium
 - [ ] ID-13
Reentrancy in [ItemBlocks.createPassport(uint256,string,string,string,string,string)](src/ItemBlocks.sol#L36-L40):
	External calls:
	- [_safeMint(msg.sender,tokenId)](src/ItemBlocks.sol#L37)
		- [retval = IERC721Receiver(to).onERC721Received(_msgSender(),from,tokenId,data)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L467-L480)
	Event emitted after the call(s):
	- [PassportUpdate(tokenId,msg.sender,Role.Owner,name,desc,family,url,img)](src/ItemBlocks.sol#L53-L61)
		- [updatePassport(tokenId,name,desc,family,url,img)](src/ItemBlocks.sol#L39)
	- [PassportUpdate(tokenId,msg.sender,Role.Creator,name,desc,family,url,img)](src/ItemBlocks.sol#L53-L61)
		- [updatePassport(tokenId,name,desc,family,url,img)](src/ItemBlocks.sol#L39)

src/ItemBlocks.sol#L36-L40


## assembly
Impact: Informational
Confidence: High
 - [ ] ID-14
[Strings.toString(uint256)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L24-L44) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L30-L32)
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L36-L38)

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L24-L44


 - [ ] ID-15
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L130-L133)
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L154-L161)
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L167-L176)

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-16
[ERC721._checkOnERC721Received(address,address,uint256,bytes)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L465-L482) uses assembly
	- [INLINE ASM](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L476-L478)

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L465-L482


## pragma
Impact: Informational
Confidence: High
 - [ ] ID-17
Different versions of Solidity are used:
	- Version used: ['^0.8.18', '^0.8.20']
	- [^0.8.18](src/ItemBlocks.sol#L2)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/access/Ownable.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#L3)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/Context.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L4)
	- [^0.8.20](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L4)

src/ItemBlocks.sol#L2


## dead-code
Impact: Informational
Confidence: Medium
 - [ ] ID-18
[Strings.toHexString(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L65-L78) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L65-L78


 - [ ] ID-19
[Context._contextSuffixLength()](lib/openzeppelin-contracts/contracts/utils/Context.sol#L25-L27) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Context.sol#L25-L27


 - [ ] ID-20
[ERC721._safeTransfer(address,address,uint256,bytes)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L385-L388) is never used and should be removed

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L385-L388


 - [ ] ID-21
[Math.ceilDiv(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L107-L115) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L107-L115


 - [ ] ID-22
[SignedMath.min(int256,int256)](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L20-L22) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L20-L22


 - [ ] ID-23
[Math.log10(uint256,Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L359-L364) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L359-L364


 - [ ] ID-24
[Math.mulDiv(uint256,uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L123-L202


 - [ ] ID-25
[ERC721._transfer(address,address,uint256)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L346-L356) is never used and should be removed

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L346-L356


 - [ ] ID-26
[Math.tryDiv(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L61-L66) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L61-L66


 - [ ] ID-27
[SignedMath.average(int256,int256)](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L28-L32) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L28-L32


 - [ ] ID-28
[Strings.toHexString(uint256)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L56-L60) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L56-L60


 - [ ] ID-29
[Math.sqrt(uint256,Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L257-L262) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L257-L262


 - [ ] ID-30
[Math.max(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L81-L83) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L81-L83


 - [ ] ID-31
[Math.log2(uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L268-L304) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L268-L304


 - [ ] ID-32
[Math.average(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L96-L99) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L96-L99


 - [ ] ID-33
[Math.log2(uint256,Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L310-L315) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L310-L315


 - [ ] ID-34
[ERC721._burn(uint256)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L328-L333) is never used and should be removed

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L328-L333


 - [ ] ID-35
[Math.log256(uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L372-L396) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L372-L396


 - [ ] ID-36
[Math.log256(uint256,Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L402-L407) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L402-L407


 - [ ] ID-37
[Math.sqrt(uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L221-L252) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L221-L252


 - [ ] ID-38
[Math.tryAdd(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L25-L31) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L25-L31


 - [ ] ID-39
[Context._msgData()](lib/openzeppelin-contracts/contracts/utils/Context.sol#L21-L23) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Context.sol#L21-L23


 - [ ] ID-40
[Math.mulDiv(uint256,uint256,uint256,Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L207-L213) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L207-L213


 - [ ] ID-41
[Strings.toHexString(address)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L84-L86) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L84-L86


 - [ ] ID-42
[Strings.toStringSigned(int256)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L49-L51) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L49-L51


 - [ ] ID-43
[Math.trySub(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L36-L41) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L36-L41


 - [ ] ID-44
[Math.tryMul(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L46-L56) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L46-L56


 - [ ] ID-45
[Strings.equal(string,string)](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L91-L93) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L91-L93


 - [ ] ID-46
[Math.tryMod(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L71-L76) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L71-L76


 - [ ] ID-47
[Math.min(uint256,uint256)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L88-L90) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L88-L90


 - [ ] ID-48
[SignedMath.max(int256,int256)](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L13-L15) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L13-L15


 - [ ] ID-49
[SignedMath.abs(int256)](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L37-L42) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L37-L42


 - [ ] ID-50
[ERC721._safeTransfer(address,address,uint256)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L377-L379) is never used and should be removed

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L377-L379


 - [ ] ID-51
[Math.unsignedRoundsUp(Math.Rounding)](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L412-L414) is never used and should be removed

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L412-L414


 - [ ] ID-52
[ERC721._increaseBalance(address,uint128)](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L224-L228) is never used and should be removed

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L224-L228


## solc-version
Impact: Informational
Confidence: High
 - [ ] ID-53
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/access/Ownable.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/access/Ownable.sol#L4


 - [ ] ID-54
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol#L4


 - [ ] ID-55
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/math/Math.sol#L4


 - [ ] ID-56
solc-0.8.22 is not recommended for deployment

 - [ ] ID-57
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/introspection/IERC165.sol#L4


 - [ ] ID-58
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#L4


 - [ ] ID-59
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/token/ERC721/IERC721.sol#L4


 - [ ] ID-60
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/introspection/ERC165.sol#L4


 - [ ] ID-61
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/Context.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/Context.sol#L4


 - [ ] ID-62
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/utils/Strings.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/utils/Strings.sol#L4


 - [ ] ID-63
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/token/ERC721/IERC721Receiver.sol#L4


 - [ ] ID-64
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#L4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/token/ERC721/extensions/IERC721Metadata.sol#L4


 - [ ] ID-65
Pragma version[^0.8.20](lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#L3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.

lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#L3


