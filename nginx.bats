@test "nginx binary is found in $PATH" {
    run which nginx
    [ "$status" -eq 0 ]
}

@test "nginx attempts to hit an upstream server" {
    result="$(curl -Is -H 'Host: www.example.com' http://127.0.0.1/ | head -n 1 | awk '{print $2}')"
    [ $result -eq 502 ]
}

@test "nginx goes into maintenance mode" {
    touch /www/maintenance-on;
    result="$(curl -Is -H 'Host: www.example.com' http://127.0.0.1/ | head -n 1 | awk '{print $2}')"
    [ $result -eq 503 ]
    rm /www/maintenance-on;
}

@test "nginx can be put into maintenance mode with webdav" {
    result="$(curl -X PUT -i -d '' -ks -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 401 ]
    result="$(curl -u davuser:foobar -X PUT -i -d '' -ks -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 201 ]
    result="$(curl -Is -H 'Host: www.example.com' http://127.0.0.1/ | head -n 1 | awk '{print $2}')"
    [ $result -eq 503 ]
    rm -f /www/maintenance-on;
}

@test "nginx can be taken out of maintenance mode with webdav" {
    touch /www/maintenance-on;
    result="$(curl -X DELETE -i -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 401 ]
    result="$(curl -u davuser:foobar -X DELETE -i -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 204 ]
    result="$(curl -Is -H 'Host: www.example.com' http://127.0.0.1/ | head -n 1 | awk '{print $2}')"
    [ $result -eq 502 ]
}

@test "nginx does not allow webdav methods other than PUT or DELETE" {
    result="$(curl -X GET -i -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 403 ]
    result="$(curl -I -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    [ $result -eq 403 ]
    #result="$(curl -X PROPFIND -i -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    #[ $result -eq 403 ]
    #result="$(curl -X POST -d '' -i -s -H 'Host: www.example.com' http://127.0.0.1/maintenance-on | head -n 1 | awk '{print $2}')"
    #[ $result -eq 403 ]
}

