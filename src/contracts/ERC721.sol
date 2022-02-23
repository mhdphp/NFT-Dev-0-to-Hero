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

contract ERC721 {

    // address from - the contract address
    // address to - the owner address
    event Transfer(
        address indexed from, 
        address indexed to, 
        uint256 indexed tokenId);

    // mapping in solidity creates a hash table of key pair values
    // mapping from token id to the owner
    mapping(uint256 => address) private _tokenOwner;

    // mappint from owner to number of owned tokens
    mapping(address => uint256) private _OwnedTokensCount;

    /// @notice Count all NFTs assigned to an owner
    /// @dev NFTs assigned to the zero address are considered invalid, and this
    ///  function throws for queries about the zero address.
    /// @param _owner An address for whom to query the balance
    /// @return The number of NFTs owned by `_owner`, possibly zero
    function balanceOf(address _owner) external view returns (uint256){
        require(_owner != address(0), "_owner address should not be 0");
        return _OwnedTokensCount[_owner];
    }

    /// @notice Find the owner of an NFT
    /// @dev NFTs assigned to zero address are considered invalid, and queries
    ///  about them do throw.
    /// @param _tokenId The identifier for an NFT
    /// @return The address of the owner of the NFT
    function ownerOf(uint256 _tokenId) external view returns (address){
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

    function _mint(address to, uint256 tokenId) internal {
        // require that the address is not zero (it is a valid address)
        require(to != address(0), 'ERC721: minting to a zero address');
        // require that the tokenId doesn't exist (was not minted previously)
        require(!_exists(tokenId), 'ERC721: token already minted (exists)');
        // we are adding a new address to the tokenId for minting
        _tokenOwner[tokenId] = to;
        // we increase the counter of Owner address with one unit (total minted tokens)
        _OwnedTokensCount[to] += 1;

        // for the moment we keept the contract address to zero
        emit Transfer(address(0), to, tokenId);
    }

}