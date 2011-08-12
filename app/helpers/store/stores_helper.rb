module Store::StoresHelper
  def showSteps(store)
  	return (!b_to_i (store.first_step) or !b_to_i (store.authorize_net!=nil) or !b_to_i (store.plans.count>0))
  end
end
