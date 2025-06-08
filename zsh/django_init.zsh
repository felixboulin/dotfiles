function init_django_shell() {
  source ./venv/bin/activate
  alias m=./manage.py
  echo "All set, you can now use the 'm' alias to run manage.py commands"
}

alias di=init_django_shell

