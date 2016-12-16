import MainView from './main';
import EntrantShowView from './entrant/show';
import RaffleShowView from './raffle/show';

// Collection of specific view modules
const views = {
  EntrantShowView: EntrantShowView,
  RaffleShowView: RaffleShowView,
};

export default function loadView(viewName) {
  return views[viewName] || MainView;
}
