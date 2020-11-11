export const SIGNUP = 'SIGNUP';

export const LOGIN = 'LOGIN';

export const LOGOUT = 'LOGOUT';

export const signup = (name, email, password, store_name, location, address, phone) => {
    console.log("email");
    console.log(email);
    console.log(name)
    console.log(store_name)
    console.log(location)
    console.log(address)
    console.log(phone)
    return async dispatch => {
      const response = await fetch(
        'https://chats-backend.herokuapp.com/api/v1/vendors/auth/register',
        // 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
        {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',

          },
          body: JSON.stringify({
            name: name,
            email: email,
            password: password,
            store_name: store_name,
            location: location,
            address: address,
            phone: phone
            // returnSecureToken: true
          })
        });
      
      if(!name.trim() || !email.trim() || !password.trim() || !store_name.trim() || !phone.trim()) {
        const message = 'Please fill missing form details!';
        throw new Error(message);
      }
  
      if (!response.ok) {
          const resData = await response.json();
          // const errorId = resData.error.message;
          // let message = 'Something went wrong!';
          // if (errorId === 'EMAIL_EXISTS') {
          //   message = 'This email is already registered!';
          // }
          console.log(resData.message, resData.status, resData)
          throw new Error(resData.message);
      }
      
      const resData = await response.json();
      console.log(resData);
      dispatch({ type: SIGNUP, 
        // token: resData.token, 
        // userId: resData.localId 
      });
    };
  };


  export const login = (email, password) => {
    console.log("email");
    console.log(email);
    console.log(password)
    return async dispatch => {
      const response = await fetch(
          'https://chats-backend.herokuapp.com/api/v1/vendors/auth/login',
        // 'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAwgIWUA56_htYICcVGRnHdxPNYAbPTzPI',
        {
          method: 'POST',
          headers: {
            
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            email: email,
            password: password,
            // returnSecureToken: true
          })
        }
      );
      
      if(!email.trim() || !password.trim()) {
        const message = 'Please fill missing form details!';
        throw new Error(message);
      }

      if (!response.ok) {
        const resData = await response.json();
        // const errorId = resData.error.message;
        // let message = 'Please fill form details!';
        // if (errorId === 'EMAIL_NOT_FOUND') {
        //   message = 'This user is not registered!';
        // } else if (errorId === 'INVALID_PASSWORD') {
        //   message = 'This password is not valid!';
        // }
        console.log(resData, resData.message)
        throw new Error(resData);
      }
  
      const resData = await response.json();
      console.log(resData);
      dispatch({ type: LOGIN, 
                  // token: resData.token, 
                  // userId: resData.user.id 
                });
    };
  };
  
  export const logout = () => {
    return { type: LOGOUT };
  };