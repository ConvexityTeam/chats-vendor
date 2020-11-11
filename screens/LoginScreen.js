import React, { useState, useEffect, useReducer, useCallback } from 'react';
import { StyleSheet, View, TouchableOpacity, Alert, ActivityIndicator, KeyboardAvoidingView, ImageBackground } from 'react-native';
import { Button, Input, Text } from '@ui-kitten/components';
// import photo  from '../assets/BlackWomanFeelingSick.png'
// import { BlurView } from "@react-native-community/blur";
import InputField from '../components/InputField';
// import { ImageOverlay } from '../extra/image-overlay.component';
// import {
//   EyeIcon,
//   EyeOffIcon,
//   FacebookIcon,
//   GoogleIcon,
//   PersonIcon,
//   TwitterIcon,
// } from '../icons/icons';
import { useDispatch } from 'react-redux';
import { useNavigation } from '@react-navigation/native'
// import { KeyboardAvoidingView } from '../extra/3rd-party';

import * as authActions from '../store/actions/auth';

const FORM_INPUT_UPDATE = 'FORM_INPUT_UPDATE';

const formReducer = (state, action) => {
  if (action.type === FORM_INPUT_UPDATE) {
    const updatedValues = {
      ...state.inputValues,
      [action.input]: action.value
    };
    const updatedValidities = {
      ...state.inputValidities,
      [action.input]: action.isValid
    };
    let updatedFormIsValid = true;
    for (const key in updatedValidities) {
      updatedFormIsValid = updatedFormIsValid && updatedValidities[key];
    }
    return {
      formIsValid: updatedFormIsValid,
      inputValidities: updatedValidities,
      inputValues: updatedValues
    };
  }
  return state;
};

const Login = props => {
  const navigation = useNavigation()
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState();
  const [isSignup, setIsSignup] = useState(false);
  const dispatch = useDispatch();

  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      email: '',
      password: ''
    },
    inputValidities: {
      email: false,
      password: false
    },
    formIsValid: false
  });

  useEffect(() => {
    if (error) {
      Alert.alert('An Error Occurred!', error, [{ text: 'Okay' }]);
    }
  }, [error]);

  const authHandler = async () => {
    setError(null);
    setIsLoading(true);
    try { 
      await dispatch(
        authActions.login(
          formState.inputValues.email,
          formState.inputValues.password,
        )
      );
      navigation.navigate('Dashboard')
    } catch (err){
      setError(err.message);
      setIsLoading(false);
    }
  };


  const inputChangeHandler = useCallback(
    (inputIdentifier, inputValue, inputValidity) => {
      dispatchFormState({
        type: FORM_INPUT_UPDATE,
        value: inputValue,
        isValid: inputValidity,
        input: inputIdentifier
      });
    },
    [dispatchFormState]
  );

  return (
      // source={{uri: 'https://images.unsplash.com/photo-1542736667-069246bdbc6d'}} style={{width: '100%', height: '100%'}}
      // <ImageBackground style={styles.absolute} source={photo} >
        
        <View style={styles.container}>
        <View style={styles.headerContainer}>
            <Text
              category='h1'
              status='control'
              style={{fontFamily: 'gilroy-bold'}}
              >
              Hello
            </Text>
            <TouchableOpacity onPress={() => {
                    props.navigation.navigate('SignUp')
                    }}>
              <Text
                style={styles.signInLabel}
                category='s1'
                status='control'>
                Sign in to your account
              </Text>
            </TouchableOpacity>
          </View>
          <View style={styles.formContainer}>
            <InputField
              id="email"
              placeholder='Email'
              onInputChange={inputChangeHandler}
              initialValue=""
              // icon={PersonIcon}
              // value={email}
              // onChangeText={setEmail}
            />
            <InputField
              style={styles.passwordInput}
              id="password"
              placeholder='Password'
              onInputChange={inputChangeHandler}
              initialValue=""
              // icon={passwordVisible ? EyeIcon : EyeOffIcon}
              // value={password}
              // secureTextEntry={!passwordVisible}
              // onChangeText={setPassword}
              // onIconPress={onPasswordIconPress}
            />
            <View style={styles.forgotPasswordContainer}>
            
              <Button
                style={styles.forgotPasswordButton}
                appearance='ghost'
                status='control'
                // onPress={onForgotPasswordButtonPress}
                >
                Forgot your password?
              </Button>
             
            </View>
          </View>
          {

          }
          {isLoading ? (
                <ActivityIndicator size="small" color={'white'} />
              ) : (
          <Button
            style={styles.signInButton}
            status='control'
            size='giant'
            onPress={authHandler}
            >
            SIGN IN
          </Button>
          )}
          <Button
            style={styles.signUpButton}
            appearance='ghost'
            status='control'
            onPress={() => {
              props.navigation.navigate('SignUp')
              }}
            >
            Don't have an account? Sign Up
          </Button>
        </View>
      // </ImageBackground>
    
  );
}

// const styles = StyleSheet.create({
//   container: {
//     flex: 1,
//     backgroundColor: '#fff',
//     alignItems: 'center',
//     justifyContent: 'center',
//   },
// });

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#59b2ab'
  },
  headerContainer: {
    minHeight: 216,
    justifyContent: 'center',
    alignItems: 'center',
  },
  formContainer: {
    flex: 1,
    paddingHorizontal: 16,
  },
  signInLabel: {
    marginTop: 16,
    fontFamily: 'gilroy-bold'
  },
  passwordInput: {
    marginTop: 16,
  },
  signInButton: {
    marginHorizontal: 16,
  },
  forgotPasswordContainer: {
    flexDirection: 'row',
    justifyContent: 'flex-end',
  },
  forgotPasswordButton: {
    paddingHorizontal: 0,
  },
  signUpButton: {
    marginVertical: 12,
  },
  image: {
    width: '100%',
    height: '100%',
    marginTop: 32,
    resizeMode: "cover",
    justifyContent: "center"
  },
  absolute: {
    position: "absolute",
    top: 0,
    left: 0,
    bottom: 0,
    right: 0
  }
});



export default Login;

