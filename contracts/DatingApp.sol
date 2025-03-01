// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

/*
    * DatingApp
    * A simple dating app smart contract that allows users to create profiles, like other users' profiles, and match with other users.
*/

contract DatingApp {
    struct Profile {
        string name;
        uint256 age;
        string gender;
        string bio;
        address[] likes;
    }

    mapping(address => Profile) public profiles; // Mapping of user addresses to profiles
    uint256 public profileCount; // Counter for the total number of profiles
    mapping(address => address[]) public matches; // Mapping of user addresses to matches

    /// @notice Emitted when a new profile is created
    /// @param user The address of the user who created the profile
    /// @param name The name of the user
    /// @param age The age of the user
    /// @param gender The gender of the user
    /// @param bio The bio of the user
    event ProfileCreated(address indexed user, string name, uint256 age, string gender, string bio);

    /// @notice Emitted when a profile is updated
    /// @param user The address of the user who updated the profile
    /// @param name The new name of the user
    /// @param age The new age of the user
    /// @param gender The new gender of the user
    /// @param bio The new bio of the user
    event ProfileUpdated(address indexed user, string name, uint256 age, string gender, string bio);

    /// @notice Emitted when a user likes another user's profile
    /// @param from The address of the user who liked the profile
    /// @param to The address of the user whose profile was liked
    event Liked(address indexed from, address indexed to);

    /// @notice Emitted when two users match
    /// @param user1 The address of the first user
    /// @param user2 The address of the second user
    event Matched(address indexed user1, address indexed user2);

    /// @notice Modifier to check if a profile exists for a given user
    /// @param user The address of the user to check
    modifier profileExists(address user) {
        require(bytes(profiles[user].name).length > 0, "Profile does not exist");
        _;
    }

    /// @notice Create a new profile
    /// @param _name The name of the user
    /// @param _age The age of the user
    /// @param _gender The gender of the user
    /// @param _bio The bio of the user
    function createProfile(string memory _name, uint256 _age, string memory _gender, string memory _bio) public {
        require(bytes(profiles[msg.sender].name).length == 0, "Profile already exists");
        profileCount++;
        emit ProfileCreated(msg.sender, _name, _age, _gender, _bio);
        emit ProfileCreated(msg.sender, _name, _age, _gender, _bio);
    }

    /// @notice Update an existing profile
    /// @param _name The new name of the user
    /// @param _age The new age of the user
    /// @param _gender The new gender of the user
    /// @param _bio The new bio of the user
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

    /// @notice Like another user's profile
    /// @param _to The address of the user whose profile is being liked
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

    /// @notice Check if a user is liked by another user
    /// @param _user The address of the user to check
    /// @param _likedBy The address of the user who might have liked the profile
    /// @return bool True if the user is liked by the other user, false otherwise
    function isLikedBy(address _user, address _likedBy) internal view returns (bool) {
        address[] memory likes = profiles[_user].likes;
        for (uint256 i = 0; i < likes.length; i++) {
            if (likes[i] == _likedBy) {
                return true;
            }
        }
        return false;
    }

    /// @notice Get the profile of a user
    /// @param _user The address of the user whose profile is being requested
    /// @return name The name of the user
    /// @return age The age of the user
    /// @return gender The gender of the user
    /// @return bio The bio of the user
    /// @return likes The addresses of the users who liked this profile
    function getProfile(address _user)
        public
        view
        profileExists(_user)
        returns (string memory, uint256, string memory, string memory, address[] memory)
    {
        Profile memory profile = profiles[_user];
        return (profile.name, profile.age, profile.gender, profile.bio, profile.likes);
    }

    /// @notice Get the matches of a user
    /// @param _user The address of the user whose matches are being requested
    /// @return The addresses of the users who matched with this user
    function getMatches(address _user) public view profileExists(_user) returns (address[] memory) {
        return matches[_user];
    }

    /**
     * @notice Deletes the profile of the caller.
     * @dev This function removes the profile and matches of the caller from the storage.
     * @custom:modifier profileExists Ensures that the profile of the caller exists before deletion.
     */
    function deleteProfile() public profileExists(msg.sender) {
        delete profiles[msg.sender];
        delete matches[msg.sender];
        profileCount--;
    }

    /**
     * @notice Returns the total number of profiles.
     * @return The total number of profiles.
     */
    function getTotalProfiles() public view returns (uint256) {
        return profileCount;
    }

    /// @notice Get the total number of matches for a user
    /// @param _user The address of the user whose matches count is being requested
    /// @return The total number of matches
    function getTotalMatches(address _user) public view returns (uint256) {
        return matches[_user].length;
    }

    /// @notice Get the address of the user at a specific index in the matches array
    /// @param _user The address of the user whose match is being requested
    /// @param _index The index of the match
    /// @return The address of the user at the specified index
    function getMatchAtIndex(address _user, uint256 _index) public view returns (address) {
        return matches[_user][_index];
    }
}
