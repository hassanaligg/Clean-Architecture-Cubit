/*
import 'package:dawaa24/core/data/model/nationality_model.dart';
import 'package:dawaa24/features/auth/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NationalityPicker extends StatelessWidget {
  final Function? onItemSelect;
  final double mediaQueryHeight = 0.0;
  final double mediaQueryWidth = 0.0;

  const NationalityPicker({Key? key, @required this.onItemSelect})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<RegisterCubit>(context);

    return BlocConsumer<RegisterCubit, RegisterState>(
      bloc: cubit,
      listener: (context, state) {},
      builder: (context, state) {
        return SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    initialValue: '',
                    onChanged: (value) {
                      // nationalityProviderModel.filter(value);
                      // feedBackProviderModel.setName = value.trim();
                    },
                    // style: ThemeStyle.blackNormal,
                    // decoration: _decoration(hintText: contentWord(search)!),
                  ),
                  const SizedBox(height: 10),
                  cubit.nationalities.isEmpty
                      ? const Center(
                          // child: Text("No Nationalities"),
                          child: CupertinoActivityIndicator(),
                        )
                      : cubit.nationalities.isEmpty
                          ? Row(
                              children: [
                                _buildCountryTile(
                                  cubit.nationalities[0],
                                  context,
                                ),
                                const Icon(
                                  Icons.sentiment_dissatisfied,
                                  // color: ThemeColors.black,
                                )
                              ],
                            )
                          : Flexible(
                              child: ListView.builder(
                                itemCount: cubit.nationalities.length,
                                itemBuilder: (context, index) {
                                  if (cubit.nationalities[index].id == -1) {
                                    return _buildCountryTileError(
                                      cubit.nationalities[index],
                                      context,
                                    );
                                  }
                                  return _buildCountryTile(
                                    cubit.nationalities[index],
                                    context,
                                  );
                                },
                              ),
                            ),
                  const SizedBox(height: 30),
                ],
              ),
            ));
      },
    );
  }

  Widget _buildCountryTile(
    NationalityModel nationalityModel,
    BuildContext context,
  ) {
    return Column(
      children: [
        ListTile(
          dense: true,
          title: Text(
            nationalityModel.name!,
            //  style: ThemeStyle.blackNormal,
          ),
          onTap: () {
            //      onItemSelect!(countryModel);
            Navigator.pop(context);
          },
        ),
        const Divider()
      ],
    );
  }

  Widget _buildCountryTileError(
      NationalityModel nationalityModel, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // onItemSelect(countryModel);
        // Navigator.pop(context);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  nationalityModel.name!,
                  //  style: ThemeStyle.blackNormal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/
