// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
contract IdeoNft is ERC721Enumerable, AccessControl {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string _baseTokenURI = "";
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    uint256 internal _cap = 20; //total number of tokens
    uint256[20000+1] public shuffledarray;
    uint256 usedLength = 0;
    uint256 public tokenCounter;
    event ShuffledArrayLoaded(
        uint256 indexed _fromIndex,
        uint256 indexed _numItems
    );
    constructor() ERC721("IdeoNft", "IFN") {
        // _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
        // _setupRole(MINTER_ROLE, _msgSender());
        tokenCounter = 0;
    }
    function getShuffledArray() public view returns (uint256[20000+1] memory) {
        return shuffledarray;
    }
    function getShuffledArrayLength() public view returns (uint256) {
        return shuffledarray.length;
    }
    function getShuffledArrayIndexValue(uint256 index) public view returns (uint256) {
        uint256 value = shuffledarray[index];
        return value;
    }
    function cap() external view returns (uint256) {
        return _cap;
    }
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721Enumerable, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }
    function setBaseURI(string memory baseURI) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "Caller is not a admin");
        _baseTokenURI = baseURI;
    }
    function loadshuffledarray(uint256[] memory types, uint256 offset)
        external
    {
        for (uint256 i; i < types.length; i++) {
            uint256 idx = i + offset;
            shuffledarray[idx] = types[i];
        }
        emit ShuffledArrayLoaded(offset, types.length);
    }
    function mint(address _mintTo) public returns (bool) {
        _safeMint(_mintTo, shuffledarray[tokenCounter]);
        tokenCounter++;
        return true;
    }
}