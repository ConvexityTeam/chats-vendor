import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';

import SplashScreen from '../screens/SplashScreen';
import Login from '../screens/LoginScreen';
import SignUp from '../screens/SignUpScreen';
import Dashboard from '../screens/DashboardScreen';
import AcceptPayment from '../screens/AcceptPaymentScreen';
import Wallet from '../screens/WalletScreen';
import Profile from '../screens/ProfileScreen';
// import UserTerms from '../screens/index/UserTermsScreen';

// import Search from '../screens/Search';
// import Branches from '../screens/Branches';
// import Navigation from '../screens/Navigation';
// import Notification from '../screens/Notification';
// import Drugs from '../screens/Drugs';
// import Drug from '../screens/Drug';

const Stack = createStackNavigator();


const AppNavigation = () => {
    return (
        <NavigationContainer>
          <Stack.Navigator initialRouteName="Home">
            <Stack.Screen name="Home" component={SplashScreen} options={{headerShown: false}} />
            <Stack.Screen name="Login" component={Login} options={{headerShown: false}} />
            <Stack.Screen name="Dashboard" component={Dashboard} options={({ route }) => ({ headerTitle: getHeaderTitle(route),}), {headerShown: false}} />
            <Stack.Screen name="SignUp" component={SignUp} options={{headerShown: false}} />
            <Stack.Screen name="AcceptPayment" component={AcceptPayment} options={{headerShown: true, title: 'Accept Payment'}} />
            <Stack.Screen name="Wallet" component={Wallet} options={{headerShown: true}} />
            <Stack.Screen name="Profile" component={Profile} options={{headerShown: true}} />
            {/* <Stack.Screen name="UserTerms" component={UserTerms} options={{ title: 'User Terms' }}/> */}
            {/* <Stack.Screen name="Search" component={Search} options={{headerShown: false}} />
            <Stack.Screen name="Branches" component={Branches} />
            <Stack.Screen name="Drugs" component={Drugs} />           
            <Stack.Screen name="Drug" component={Drug} />            
            <Stack.Screen name="Navigation" component={Navigation}  />
            <Stack.Screen name="Notification" component={Notification} options={{ title: 'Convert Token OTP' }} /> */}
          </Stack.Navigator>
          
        </NavigationContainer>
      );
}

export default AppNavigation;