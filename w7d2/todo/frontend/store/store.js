import { createStore } from 'redux';
import rootReducer from '../reducers/root_reducer';

const configureStore = () => createStore(rootReducer);
// Need to have export on line 6 instead of export const on line 4
export default configureStore;
