defmodule Fantastic.AppRouter do
  import Plug.Conn
  use Plug.Router

  plug :match
  plug :dispatch

  # TODO
  # forward "/login",    to: LoginRouter
  # forward "/logout",   to: LogoutRouter


  # TODO
  # # Account management
  #
  # forward "/manage/account", to: ManageAccountRouter


  # TODO
  # # User management
  #
  # forward "/manage/users", to: ManageUsersRouter


  forward "/api", to: Fantastic.ApiRouter
  forward "/", to: Fantastic.NoRouteFoundRouter
end
