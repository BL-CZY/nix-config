while [ true ]; do
    case $(eww get countdown) in
        "3")
            eww update countdown="2"
        ;;

        "2")
            eww update countdown="1"
        ;;

        "1")
            eww update countdown="0"
            eww close popup_vol
        ;;
    esac
    sleep 1
done