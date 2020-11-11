
import React, { useState } from 'react';
import { AppLoading } from 'expo';
import * as Font from 'expo-font';
import * as eva from '@eva-design/eva';
import { ApplicationProvider } from '@ui-kitten/components';
import AppNavigation from './navigation/index';
import { createStore, combineReducers, applyMiddleware, } from 'redux';
import { Provider } from 'react-redux';
import authReducer from './store/reducers/auth';
import ReduxThunk from 'redux-thunk'; 

const fetchFonts = () => {
  return Font.loadAsync({
    'gilroy-bold': require('./assets/fonts/Gilroy-Bold.ttf'),
    'gilroy-heavy': require('./assets/fonts/Gilroy-Heavy.ttf'),
    'gilroy-light': require('./assets/fonts/Gilroy-Light.ttf'),
    'gilroy-medium': require('./assets/fonts/Gilroy-Medium.ttf'),
    'gilroy-regular': require('./assets/fonts/Gilroy-Regular.ttf')
  })
}

const rootReducers = combineReducers({
  auth: authReducer
})

const store = createStore(rootReducers, applyMiddleware(ReduxThunk))

export default function App() {

  const  [fontLoaded, setFontLoaded ] = useState(false)

  if(!fontLoaded) {
    return (
      <AppLoading 
        startAsync={fetchFonts}
        onFinish={() => setFontLoaded(true)}
      />
    )
  }

  return (
    <ApplicationProvider {...eva} theme={eva.dark}>
      <Provider store={store}>
        <AppNavigation />
      </Provider>
    </ApplicationProvider>
  );
}