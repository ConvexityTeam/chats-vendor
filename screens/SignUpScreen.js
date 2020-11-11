import React, { 
  useState, useEffect, useReducer, useCallback 
} from 'react';
import { useDispatch } from 'react-redux';
import { Button, CheckBox, Input } from '@ui-kitten/components';
// import { EmailIcon, EyeIcon, EyeOffIcon, PersonIcon, PlusIcon } from './extra/icons';
import { StyleSheet, Text, View, Alert, ActivityIndicator, ImageBackground,TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/native'
// import Input from '../components/InputField';
import * as authActions from '../store/actions/auth';
import InputField from '../components/InputField';

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


const SignUp = props => {
  const navigation = useNavigation()
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState();
  const [isSignup, setIsSignup] = useState(false);
  const dispatch = useDispatch();

  const [formState, dispatchFormState] = useReducer(formReducer, {
    inputValues: {
      name: '',
      email: '',
      password: '',
      store_name: '',
      location: '',
      address: '',
      phone: ''
    },
    inputValidities: {
      name: false,
      email: false,
      password: false,
      store_name: false,
      location: false,
      address: false,
      phone: false
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
        authActions.signup(
          formState.inputValues.name,
          formState.inputValues.email,
          formState.inputValues.password,
          formState.inputValues.store_name,
          formState.inputValues.location,
          formState.inputValues.address,
          formState.inputValues.phone
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
    // <ImageBackground source={{uri: 'https://images.unsplash.com/photo-1542736667-069246bdbc6d'}} style={{width: '100%', height: '100%'}} >
    <View style={styles.container}>
    {/* <View style={styles.headerContainer}>
        <Text
          category='h1'
          status='control'>
          Hello
        </Text>
        <TouchableOpacity onPress={() => {
                props.navigation.navigate('Dashboard')
                }}>
          <Text
            style={styles.signInLabel}
            category='s1'
            status='control'>
            Sign in to your account
          </Text>
        </TouchableOpacity>
      </View> */}
      <View style={styles.formContainer}>
        <InputField
            id="name"
            autoCapitalize='none'
            placeholder='Full Name'
            // icon={PersonIcon}
            // onInputChange={inputChangeHandler}
            // initialValue=""=
          />
        <InputField
            style={styles.formInput}
            id="email"
            autoCapitalize='none'
            placeholder='Email'
            // icon={PersonIcon}
            onInputChange={inputChangeHandler}
            initialValue=""
          />
        <InputField
            style={styles.formInput}
            id="password"
            autoCapitalize='none'
            placeholder='Password'
            // icon={PersonIcon}
            // onInputChange={inputChangeHandler}
            // initialValue=""
        />
        <InputField
          style={styles.formInput}
          id="store_name"
          placeholder='Store Name'
          // keyboardType="email-address"
          // required
          // email
          // errorText="Please enter a valid email address."
          
          // icon={PersonIcon}
          onInputChange={inputChangeHandler}
          initialValue=""
        />
        <InputField
          style={styles.formInput}
          id="location"
          placeholder='Location'
          
          // icon={passwordVisible ? EyeIcon : EyeOffIcon}
          // value={password}
          // secureTextEntry={!passwordVisible}
          onInputChange={inputChangeHandler}
          initialValue=""
        />
        <InputField
            id="address"
            style={styles.formInput}
            placeholder='Address'
            autoCapitalize='none'
            
            // icon={PersonIcon}
            onInputChange={inputChangeHandler}
            initialValue=""
          />
          <InputField
            id="phone"
            style={styles.formInput}
            placeholder='Phone'
            autoCapitalize='none'
            
            // icon={PersonIcon}
            onInputChange={inputChangeHandler}
            initialValue=""
          />
          {/* <CheckBox
            style={styles.termsCheckBox}
            textStyle={styles.termsCheckBoxText}
            text='I read and agree to Terms & Conditions'
            checked={termsAccepted}
            onChange={(checked: boolean) => setTermsAccepted(checked)}
          /> */}
      </View>
    
      {isLoading ? (
        <ActivityIndicator size="small" color={'white'} />
          ) : (
        <Button
          style={styles.signInButton}
          status='control'
          size='giant'
          // onPress={onSignInButtonPress}
          onPress={authHandler}
          >
          SIGN UP
        </Button>
      )}
      
      <Button
        style={styles.signUpButton}
        appearance='ghost'
        status='control'
        onPress={() => {
          props.navigation.navigate('Login')
          }}
        >
        Already have an account? Sign In
      </Button>
    </View>
  // </ImageBackground>
  );
}

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
    paddingTop: '30%',
    paddingHorizontal: 16,
  },
  formInput: {
    marginTop: 16,
  },
  signInLabel: {
    marginTop: 16,
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
  termsCheckBox: {
    marginTop: 24,
  },
  button: {
    marginTop: 10,
    paddingTop: 10,
    paddingLeft: 5,
    paddingRight: 5,
    borderRadius: 10,
    width: "97%",
    height: 50,
    
  },
  // termsCheckBoxText: {
  //   color: 'text-control-color',
  // },
});

export default SignUp;