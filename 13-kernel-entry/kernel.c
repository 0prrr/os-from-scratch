void mess_up()
{

}

void entry_point()
{
    char* video_memory = (char*)0xb8000;
    *video_memory = 'X';
}
