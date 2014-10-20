@test "nginx binary is found in $PATH" {
    run which nginx
    [ "$status" -eq 0 ]
}

@test "nginx is configured to use the maintenance page" {
    run 
}
