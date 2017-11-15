import { createStore, applyMiddleware } from 'redux';
import rootReducer from '../reducers/root_reducer';
import {thunkMiddleware} from './../middleware/thunk';

const configureStore = () => createStore(rootReducer, applyMiddleware(thunkMiddleware));
// Need to have export on line 6 instead of export const on line 4
export default configureStore;
