import 'package:flutter/material.dart';
import 'package:movies/Model/MovieModel.dart';
import 'package:movies/Services/api_services.dart';
import 'package:movies/Utils/model_text.dart';
import 'package:video_player/video_player.dart';

class MovesScreen extends StatefulWidget {
  const MovesScreen({super.key});

  @override
  State<MovesScreen> createState() => _MovesScreenState();
}

class _MovesScreenState extends State<MovesScreen> {

  ApiServices _apiServices=ApiServices();
bool tap=false;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Movie AppLication',
          style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.blue,
        actions: [
          Switch(
              value: tap,
              onChanged: (onChanged){
                setState(() {
                  tap=onChanged;
                });
              }),
        ],
      ),

      body: FutureBuilder(
          future: _apiServices.MoviesData(),
          builder: (context,AsyncSnapshot<MovieModel>snapshot){
          if(snapshot.hasData){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    height: 250,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), // Circular border radius
                      shape: BoxShape.rectangle, // Optional: Explicitly set shape to rectangle
                    ),
                    child: Image.network(
                      snapshot.data!.poster.toString(),
                      fit: BoxFit.cover, // Ensures the image covers the entire container
                      width: double.infinity, // Full width
                      height: double.infinity, // Full height
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ModifyText(text: snapshot.data!.title.toString(), size: 19),
                      ModifyText(text: snapshot.data!.runtime.toString(), size: 16),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ModifyText(text: snapshot.data!.plot.toString(), size: 13),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity, // Take full width
                    color: Colors.blue, // Background color for visibility
                    padding: EdgeInsets.all(16),
                    child:tap? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModifyText(text: 'Award : ${snapshot.data!.awards.toString()}', size: 14),
                        ModifyText(text: 'BoxOffice : ${snapshot.data!.boxOffice.toString()}', size: 14),
                        ModifyText(text: 'Votes : ${snapshot.data!.imdbVotes.toString()}', size: 14),
                      ],
                    ):Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ModifyText(text: 'Country : ${snapshot.data!.country.toString()}', size: 14),
                        ModifyText(text: 'Language : ${snapshot.data!.language.toString()}', size: 14),
                        ModifyText(text: 'Writter : ${snapshot.data!.writer.toString()}', size: 14),
                        ModifyText(text: 'Actors : ${snapshot.data!.actors.toString()}', size: 14),

                      ],
                    ),
                  ),

                ],
              ),
            );
          }else if(snapshot.hasError){
            return Text('Has Error ');
          }else{
            return Center(child: CircularProgressIndicator(),);
          }
          }),
    );
  }
}
