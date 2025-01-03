import Principal "mo:base/Principal";
import Nat8 "mo:base/Nat8";
import NFTActorClass "../NFT/nft";
import Cycles "mo:base/ExperimentalCycles";
import Debug "mo:base/Debug";
import HashMap "mo:base/HashMap";
import Hash "mo:base/Hash";
import List "mo:base/List";
import Text "mo:base/Text";
import Iter "mo:base/Iter";


actor OpenD {
    
    private type Listing = {
        itemOwner:Principal;
        itemPrice:Nat;
    };
    var mapofNFTs=HashMap.HashMap<Principal , NFTActorClass.NFT>(1,Principal.equal,Principal.hash);
    var mapofOwners=HashMap.HashMap<Principal , List.List<Principal>>(1,Principal.equal,Principal.hash);
    var mapOfListings=HashMap.HashMap<Principal,Listing>(1,Principal.equal,Principal.hash);

    public shared(msg) func mint(imgData:[Nat8],name:Text): async Principal {
        let owner:Principal=msg.caller; 

        Debug.print(debug_show(Cycles.balance()));
        Cycles.add(100_500_000_000);
        let newNFT =await NFTActorClass.NFT(name,owner,imgData);
        Debug.print(debug_show(Cycles.balance())); 
        let newNFTPrincipal = await newNFT.getCanisterID();

        mapofNFTs.put(newNFTPrincipal,newNFT);
        addToOwnershipMap(owner,newNFTPrincipal);

        return newNFTPrincipal;
    };

    private func addToOwnershipMap(owner:Principal,nftID:Principal){
        var ownedNFTs:List.List<Principal> = switch ( mapofOwners.get(owner)){
            case null List.nil<Principal>();
            case (?result) result; 
        };

        ownedNFTs:=List.push(nftID,ownedNFTs);
        mapofOwners.put(owner,ownedNFTs);
    };

    public query func getOwnedNFTs(user: Principal): async [Principal] {
        var userNFTs :List.List<Principal> = switch (mapofOwners.get(user)){
            case null List.nil<Principal>();
            case (?result) result; 
        }; 
        return List.toArray(userNFTs);
    };

    public query func getListedNFTs():async [Principal]{
        let ids= Iter.toArray(mapOfListings.keys());
        return ids;
    };

    public shared(msg) func listItem(id: Principal,price: Nat):async Text{
        var item :NFTActorClass.NFT = switch(mapofNFTs.get(id)){
            case null return "NFT Does Not Exist.";
            case (?result) result;
        };

        let owner = await item.getOwner();
        if(Principal.equal(owner,msg.caller)){
            let newListing:Listing={
                itemOwner=owner;
                itemPrice=price;
            };
            mapOfListings.put(id,newListing);
            return "Success";
        }
        else{
            return "You Don't Own the NFT";
        }
        
    };

    public query func getOpenDCanisterID():async Principal{
        return Principal.fromActor(OpenD);  
    };

    public query func isListed(id:Principal) : async Bool{
        if(mapOfListings.get(id)==null){
            return false;
        }
        else{
            return true;    
        }
    };

    public query func getOriginalOwner(id : Principal):async Principal{
        var listing:Listing = switch(mapOfListings.get(id)){
            case null return Principal.fromText("");
            case (?result) result;
        };

        return listing.itemOwner;
    };

    public query func getListedNFTPrice(id: Principal): async Nat{
        var listing:Listing = switch(mapOfListings.get(id)){
            case null return 0;
            case (?result) result;
        };

       return listing.itemPrice;
    };

    public shared(msg) func completePurchase(id: Principal,ownerId: Principal,newOwnerId: Principal): async Text{
        var purchasedNFT:NFTActorClass.NFT = switch(mapofNFTs.get(id)){
            case null return "NFT does not exist";
            case (?result) result;
        };
        let transferResult = await purchasedNFT.transferOwnerShip(newOwnerId);
        if(transferResult=="Success"){
            mapOfListings.delete(id);
            var ownedNFTs : List.List<Principal> = switch(mapofOwners.get(ownerId)){
                case null List.nil<Principal>();
                case (?result) result;
            };
            ownedNFTs := List.filter(ownedNFTs,func (listItemId:Principal):Bool{
                return listItemId != id;
            });

            addToOwnershipMap(newOwnerId,id);
            return "Success";

        }
        else{
            return "Error";
        }
        
    };
};
