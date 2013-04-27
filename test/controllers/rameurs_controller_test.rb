require 'test_helper'

class RameursControllerTest < ActionController::TestCase
  setup do
    @rameur = rameurs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rameurs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rameur" do
    assert_difference('Rameur.count') do
      post :create, rameur: { email: @rameur.email, nom: @rameur.nom, prenom: @rameur.prenom }
    end

    assert_redirected_to rameur_path(assigns(:rameur))
  end

  test "should show rameur" do
    get :show, id: @rameur
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rameur
    assert_response :success
  end

  test "should update rameur" do
    patch :update, id: @rameur, rameur: { email: @rameur.email, nom: @rameur.nom, prenom: @rameur.prenom }
    assert_redirected_to rameur_path(assigns(:rameur))
  end

  test "should destroy rameur" do
    assert_difference('Rameur.count', -1) do
      delete :destroy, id: @rameur
    end

    assert_redirected_to rameurs_path
  end
end
