// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

/*
Building up the minting function
    a. NFT point to an address,
    b. Keep track of the token ids,
    c. Keep track of token owner address to token id,
    d. Keep track of how many tokens an owner has,
    e. Create an event that emit a transfer log:
        - contract address,
        - token id,
        - owener,
        - where is being minted to
        - etc
*/

import './ERC165.sol'; // ERC165.sol inherits IERC165.sol

contract ERC721 is ERC165 {

    // address from - the contract address
    // address to - the owner address
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // mapping from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    // mapping from token id to approve address
    mapping(uint256 => address) private _tokenApprovals;

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) public view returns (uint256){
        require(_owner != address(0), "_owner address should not be 0");
        return _OwnedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) public view returns (address){
        address owner = _tokenOwner[_tokenId];
        require(owner != address(0), "owner address should not be 0");
        return owner;
    }

    function _exists(uint256 tokenId) internal view returns(bool){
        // setting the address of the nft owner to a variable
        address owner = _tokenOwner[tokenId];
        // return truthiness that address is not zero;
        // return truth if the address is not zero, so the token exists
        return owner != address(0);
    }

    // this function will be override in ERC721Enumerable.sol - mark with virtual
    function _mint(address to, uint256 tokenId) internal virtual {
        // require that the address is not zero (it is a valid address)
        require(to != address(0), 'ERC721: minting to a zero address');
        // require that the tokenId doesn't exist (was not minted previously)
        require(!_exists(tokenId), 'ERC721: token already minted (exists)');
        // we are adding a new address to the tokenId for minting
        _tokenOwner[tokenId] = to;
        // we increase the counter of Owner address with one unit (total minted tokens)
        _OwnedTokensCount[to] += 1;

        // for the moment we kept the contract address to zero
        emit Transfer(address(0), to, tokenId);
    }

    /// @notice Transfer ownership of an NFT -- THE CALLER IS RESPONSIBLE
    ///  TO CONFIRM THAT `_to` IS CAPABLE OF RECEIVING NFTS OR ELSE
    ///  THEY MAY BE PERMANENTLY LOST
    /// @dev Throws unless `msg.sender` is the current owner, an authorized
    ///  operator, or the approved address for this NFT. Throws if `_from` is
    ///  not the current owner. Throws if `_to` is the zero address. Throws if
    ///  `_tokenId` is not a valid NFT.
    /// @param _from The current owner of the NFT
    /// @param _to The new owner
    /// @param _tokenId The NFT to transfer
    
    function _transferFrom(address _from, address _to, uint256 _tokenId) internal {
        // a. require that the address receiving token _to is not a zero address
        require(_to != address(0), 'Transferring to a zero address.');
        // b. require that the address _from actually owns the token
        require(ownerOf(_tokenId) == _from, "Trying to transfer a token that the address doesn't own");
        // 1. update the balance of the address _from token
        _OwnedTokensCount[_from] -= 1;
        // 2. update the balance of the address _to
        _OwnedTokensCount[_to] += 1;
        // 3. add the token id to the address receiving the token
        _tokenOwner[_tokenId] = _to;

        emit Transfer(_from, _to, _tokenId);        
    }

    // call the _transferFrom function - internal from this one
    function transferFrom(address _from, address _to, uint256 _tokenId) public payable{
        _transferFrom(_from, _to, _tokenId);
    }

}