import { StatusBar } from 'expo-status-bar';
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, Image } from 'react-native';

import { FontAwesomeIcon } from '@fortawesome/react-native-fontawesome'
import {  faQrcode, faBarcode } from '@fortawesome/free-solid-svg-icons'

// import { SplashScreen } from 'expo';

 const PayBillsScreen = props => {
 
  return (
    <View style={styles.container}>
    
      <View style={{flexDirection: "row", 
          justifyContent: "space-evenly"}}>
          <TouchableOpacity onPress={() => { }}>
          <View style={styles.card}>
            <View style={{width: 50, height: 50, borderRadius: 50 / 2, borderWidth: 2, borderColor: '#fff', backgroundColor: '#fff', justifyContent: 'center', alignItems: 'center', marginBottom: 20}}>
              <FontAwesomeIcon icon={ faBarcode } style={{color: '#222222', width: 23, height: 23}} />
            </View>
          <Text style={{
                  fontSize: 18,
                  fontFamily: 'gilroy-medium',
                  textAlign: 'center'
                  }}>Scan NFC Card</Text>
            <Text style={{
                  fontSize: 14,
                  fontFamily: 'gilroy-regular',
                  textAlign: 'center'
                  }}>Scan a customer NFC card</Text>
          </View>
          </TouchableOpacity>

          <TouchableOpacity onPress={() => {
                props.navigation.navigate('QRScanning')
            }}>
          <View style={styles.card}>
            <View style={{width: 50, height: 50, borderRadius: 50 / 2, borderWidth: 2, borderColor: '#fff', backgroundColor: '#fff', justifyContent: 'center', alignItems: 'center', marginBottom: 20}}>
              <FontAwesomeIcon icon={ faQrcode } style={{color: '#222222', width: 23, height: 23}} />
            </View>
            <Text style={{
                  fontSize: 18,
                  fontFamily: 'gilroy-medium',
                  textAlign: 'center'
                  }}>Scan QR Code</Text>
            <Text style={{
                  fontSize: 14,
                  fontFamily: 'gilroy-regular',
                  textAlign: 'center'
                  }}>Complete a payment with an already created QR code.</Text>
          </View>
          </TouchableOpacity>
        </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    paddingTop: 10,
    backgroundColor: '#fff'
  },
  header: {
    paddingLeft: 10,
    paddingRight: 20,
    flexDirection: "row", 
  },
  subheader: {
    paddingTop: 20, 
    paddingLeft: 20,
    paddingBottom: 30
  },
  card: {
    margin: 10,
    paddingTop: 20,
    paddingLeft: 10,
    paddingRight: 10,
    width: 150,
    height: 230,  
    shadowColor: "#000",
    shadowOffset: {
      width: 0,
      height: 1,
    },
    // justifyContent: "center", 
    alignItems: "center",
    shadowOpacity: 0.25,
    shadowRadius: 2,
    elevation: 4,
    borderRadius: 5,
    backgroundColor: '#EFEBF9',
    
  }
});

export default PayBillsScreen;