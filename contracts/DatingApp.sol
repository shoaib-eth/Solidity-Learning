// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

contract DatingApp {
    struct Profile {
        string name;
        uint256 age;
        string gender;
        string bio;
        address[] likes;
    }

    mapping(address => Profile) public profiles;
    mapping(address => address[]) public matches;

    event ProfileCreated(address indexed user, string name, uint256 age, string gender, string bio);
    event ProfileUpdated(address indexed user, string name, uint256 age, string gender, string bio);
    event Liked(address indexed from, address indexed to);
    event Matched(address indexed user1, address indexed user2);

    modifier profileExists(address user) {
        require(bytes(profiles[user].name).length > 0, "Profile does not exist");
        _;
    }

    function createProfile(string memory _name, uint256 _age, string memory _gender, string memory _bio) public {
        require(bytes(profiles[msg.sender].name).length == 0, "Profile already exists");
        profiles[msg.sender] = Profile(_name, _age, _gender, _bio, new address[](0));
        emit ProfileCreated(msg.sender, _name, _age, _gender, _bio);
    }

    function updateProfile(string memory _name, uint256 _age, string memory _gender, string memory _bio)
        public
        profileExists(msg.sender)
    {
        profiles[msg.sender].name = _name;
        profiles[msg.sender].age = _age;
        profiles[msg.sender].gender = _gender;
        profiles[msg.sender].bio = _bio;
        emit ProfileUpdated(msg.sender, _name, _age, _gender, _bio);
    }

    function likeProfile(address _to) public profileExists(msg.sender) profileExists(_to) {
        require(msg.sender != _to, "You cannot like your own profile");
        profiles[_to].likes.push(msg.sender);
        emit Liked(msg.sender, _to);

        if (isLikedBy(_to, msg.sender)) {
            matches[msg.sender].push(_to);
            matches[_to].push(msg.sender);
            emit Matched(msg.sender, _to);
        }
    }

    function isLikedBy(address _user, address _likedBy) internal view returns (bool) {
        address[] memory likes = profiles[_user].likes;
        for (uint256 i = 0; i < likes.length; i++) {
            if (likes[i] == _likedBy) {
                return true;
            }
        }
        return false;
    }

    function getProfile(address _user)
        public
        view
        profileExists(_user)
        returns (string memory, uint256, string memory, string memory, address[] memory)
    {
        Profile memory profile = profiles[_user];
        return (profile.name, profile.age, profile.gender, profile.bio, profile.likes);
    }

    function getMatches(address _user) public view profileExists(_user) returns (address[] memory) {
        return matches[_user];
    }
}
