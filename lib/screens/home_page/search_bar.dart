import 'package:flutter/material.dart';
import '../../../constants/color_shades.dart';

    class SearchInput extends StatefulWidget {
      const SearchInput({Key? key}) : super(key: key);
      @override
      State<SearchInput> createState() => _SearchInputState();
    }
    
    class _SearchInputState extends State<SearchInput> {
      @override
      Widget build(BuildContext context) {
        return Container(
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            children: [
              Row(
                children: [
                  Flexible(
                    //flex: 1,
                    child: TextField(
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: ColorShades.text2, width: 5.0),
                        ),
                        hintText: 'Type name of medicine here',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                  const Icon(Icons.search)
                ],
              )
            ],
          ),
        );
      }
    }