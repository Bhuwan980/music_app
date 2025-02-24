import 'package:audioplayers/audioplayers.dart';
import 'package:client/core/theme/app_pallet.dart';
import 'package:flutter/material.dart';

class PlaySong extends StatefulWidget {
  final String songTitle;
  final String artistName;
  final String songUrl;
  final String coverImage;
  final List<Map<String, String>> playlist;
  final int currentIndex;

  const PlaySong({
    super.key,
    required this.songTitle,
    required this.artistName,
    required this.songUrl,
    required this.coverImage,
    required this.playlist,
    required this.currentIndex,
  });

  @override
  State<PlaySong> createState() => _PlaySongPageState();
}

class _PlaySongPageState extends State<PlaySong> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  int currentSongIndex = 0;

  @override
  void initState() {
    super.initState();
    currentSongIndex = widget.currentIndex;
    _initAudioPlayer();
    _playSong(widget.songUrl);
  }

  void _initAudioPlayer() {
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });

    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        isPlaying = false;
        position = Duration.zero;
      });
      _playNextSong(); // Auto-play next song when the current one ends
    });
  }

  void _playPause() async {
    if (isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(UrlSource(widget.songUrl));
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void _playSong(String songUrl) async {
    await _audioPlayer.stop();
    await _audioPlayer.play(UrlSource(songUrl));
    setState(() {
      isPlaying = true;
    });
  }

  void _playNextSong() {
    if (currentSongIndex < widget.playlist.length - 1) {
      setState(() {
        currentSongIndex++;
      });
      _playSong(widget.playlist[currentSongIndex]["songUrl"]!);
    }
  }

  void _playPreviousSong() {
    if (currentSongIndex > 0) {
      setState(() {
        currentSongIndex--;
      });
      _playSong(widget.playlist[currentSongIndex]["songUrl"]!);
    }
  }

  void _seekTo(double value) {
    final seekPosition = Duration(seconds: value.toInt());
    _audioPlayer.seek(seekPosition);
  }

  void _seekForward() {
    final newPosition = position + const Duration(seconds: 10);
    _audioPlayer.seek(newPosition < duration ? newPosition : duration);
  }

  void _seekBackward() {
    final newPosition = position - const Duration(seconds: 10);
    _audioPlayer
        .seek(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text("Now Playing"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Album Cover
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(widget.coverImage,
                  height: 250, width: 250, fit: BoxFit.cover),
            ),
            const SizedBox(height: 20),

            // Song Info
            Text(
              widget.playlist[currentSongIndex]["songTitle"]!,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
            Text(
              widget.playlist[currentSongIndex]["artistName"]!,
              style: const TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Progress Bar
            Slider(
              min: 0,
              max: duration.inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              onChanged: _seekTo,
              activeColor: Pallete.gradient1,
              inactiveColor: Colors.grey,
            ),

            // Time Labels
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatTime(position),
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  _formatTime(duration),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Playback Controls (Previous, Backward, Play/Pause, Forward, Next)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_previous, color: Colors.white),
                  onPressed: _playPreviousSong,
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.replay_10, color: Colors.white),
                  onPressed: _seekBackward,
                ),
                IconButton(
                  iconSize: 60,
                  icon: Icon(
                    isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    color: Pallete.gradient1,
                  ),
                  onPressed: _playPause,
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.forward_10, color: Colors.white),
                  onPressed: _seekForward,
                ),
                IconButton(
                  iconSize: 40,
                  icon: const Icon(Icons.skip_next, color: Colors.white),
                  onPressed: _playNextSong,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }
}
