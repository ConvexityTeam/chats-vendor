
import React from 'react';
import { StyleSheet, Text, View, TouchableOpacity, Image } from 'react-native';
import photo from '../assets/chats-transparent.png'

const SplashScreen = props => {
  return (
    <View style={styles.container}>
      <Image
             source={photo}
            //borderRadius style will help us make the Round Shape Image
            style={{ width: '90%', height: 100, marginBottom: '50%' }}
          />
      <TouchableOpacity onPress={() => {props.navigation.navigate('Login')}}>
        <Text style={{fontFamily: 'gilroy-bold', fontSize: 30, lineHeight: 30}}>Enter</Text>
      </TouchableOpacity>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});

export default SplashScreen;