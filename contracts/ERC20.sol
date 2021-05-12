 pragma solidity ^0.5.13;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address _owner) external view returns (uint256 balance);

    /**
     * @dev Moves `amount` tokens from the caller's account to `recipient`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address _to, uint256 _value) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address _owner, address _spender) external view returns (uint256 remaing);

    /**
     * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * IMPORTANT: Beware that changing an allowance with this method brings the risk
     * that someone may use both the old and the new allowance by unfortunate
     * transaction ordering. One possible solution to mitigate this race
     * condition is to first reduce the spender's allowance to 0 and set the
     * desired value afterwards:
     * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
     *
     * Emits an {Approval} event.
     */
    function approve(address _spender, uint256 _value) external returns (bool success);

    /**
     * @dev Moves `amount` tokens from `sender` to `recipient` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);

    /**
     * @dev Emitted when `value` tokens are moved from one account (`from`) to
     * another (`to`).
     *
     * Note that `value` may be zero.
     */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);

    /**
     * @dev Emitted when the allowance of a `spender` for an `owner` is set by
     * a call to {approve}. `value` is the new allowance.
     */
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}


contract MyERC20Token is IERC20 {

    mapping (address => uint ) public _balances;

    // approval mapping 

    mapping (address => mapping(address => uint256)) _allowed;

    // name , symble , decimal 

    string public name = "Gopal" ;
    string public symble = "GPL" ;
    uint public decimal = 0 ;

    // uint256 _total supply 

    uint256 public _totalSupply ;

    //address -creator address

    address public _creator ;

    constructor () public {

        _creator = msg.sender ;
        _totalSupply = 500000;
        _balances[_creator] = _totalSupply;
    }

function totalSupply() external view returns (uint256) {
    return _totalSupply;
}

function balanceOf(address _owner) external view returns(uint256 balance) {
    return _balances[_owner];

}

function transfer(address _to , uint256 _value) external returns (bool success) {

    require(_value >=0 && _balances[msg.sender] >= _value);
    _balances[_to] += _value;
    _balances[msg.sender] -= _value ;
    emit Transfer(msg.sender,_to,_value);
    return true ;
}
    function approve(address _spender, uint256 _value) external returns (bool success) {
    require(_value >=0 && _balances[msg.sender] >= _value);
    _allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true ;

    }

    function transferFrom(address _from, address _to, uint256 _value)external returns(bool success) {
require(_value >=0 && _balances[msg.sender] >= _value && _allowed[_from][_to] >= _value);
    _balances[_to] += _value;
    _balances[msg.sender] -= _value ;
    _allowed[_from][_to] -= _value;
    return true ;
    }
    function allowance(address _owner, address _spender) external view returns (uint256 remaing) {
        return _allowed[_owner][_spender];
    }
}














