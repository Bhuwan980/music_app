from fastapi import FastAPI, File, Form, UploadFile

route = FastAPI()

@route.post("/upload")
def upload_song(
    song: UploadFile = File(...),
    song_name: str = Form(...),
    song_artist: str = Form(...),
    song_cover: UploadFile = File(...)
):
    return {"message": "Song uploaded successfully"}