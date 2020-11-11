import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, Image } from 'react-native';

// import { SplashScreen } from 'expo';

 const WalletScreen = props => {
 
  return (
    <View style={styles.container}>
     
      <View style={styles.walletCard}>
        <Text style={{color: '#000', fontFamily: 'gilroy-medium', fontSize: 36, lineHeight: 42}}>
          $1250.00
        </Text>
        <Text style={{color: '#555555', fontFamily: 'gilroy-medium', fontSize: 14, lineHeight: 16}}>
          Current balance
        </Text>
      </View>
      
     
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 10,
    backgroundColor: '#FFFFFF'
  },
  walletCard: {
    marginTop: 20,
    marginBottom: 0,
    marginLeft: 20,
    marginRight: 20,
    backgroundColor: '#EFEBF9',
    width: '90%',
    height: 195,  
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    justifyContent: "center", 
    alignItems: "center",
    shadowOpacity: 0.25,
    shadowRadius: 2,
    elevation: 4,
    borderRadius: 5,
  },
});

export default WalletScreen;