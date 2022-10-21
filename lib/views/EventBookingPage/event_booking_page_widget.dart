import 'package:dharmlok/views/EventDetailsPageWidget/event_detail_page_widget.dart';
import 'package:intl/intl.dart';

import '../../constants/AppColors.dart';
import '../../extensions/device_size.dart';
import 'package:dharmlok/viewModels/event_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class EventBookingPageWidget extends StatelessWidget {
  EventBookingPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _eventBookingPageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<EventViewModel>(context, listen: false).getAllEvents();
    return Consumer<EventViewModel>(
      builder: (con, eventModel, _) {
        return Scaffold(
          key: _eventBookingPageKey,
          body: SafeArea(
            child: Stack(
              children: [
                const BackgroundImageWidget(),
                const BackgroundOverlayWidget(),
                Column(
                  children: [
                    HomePageAppBarWidget(
                      scaffoldKey: _eventBookingPageKey,
                      location: 'New Delhi',
                      languageButtonPressed: () {},
                      logoutPressed: () {},
                    ),
                    SizedBox(
                      height: context.height * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.arrow_back_ios)),
                        const ImageIcon(
                          AssetImage(AppAssets.eventImageWhite),
                          color: Colors.brown,
                          size: 50,
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text(
                            AppStrings.eventBooking,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.brown,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () => eventModel.updateCategory('Sanatan'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: eventModel.category == 'Sanatan'
                                  ? Colors.orange
                                  : Colors.yellow,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Sanatan'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => eventModel.updateCategory('Buddhism'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: eventModel.category == 'Buddhism'
                                  ? Colors.orange
                                  : Colors.yellow,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  'Buddhism',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => eventModel.updateCategory('Sikh'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: eventModel.category == 'Sikh'
                                  ? Colors.orange
                                  : Colors.yellow,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Sikh'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => eventModel.updateCategory('Jain'),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.brown),
                              color: eventModel.category == 'Jain'
                                  ? Colors.orange
                                  : Colors.yellow,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(
                                      5.0) //                 <--- border radius here
                                  ),
                            ),
                            width: context.width * 0.22,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text('Jain'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    SizedBox(
                      height: context.height * 0.02,
                    ),
                    eventModel.status == Status.loading
                        ? const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : eventModel.status == Status.error
                            ? Center(
                                child: Text(
                                eventModel.error.message.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18),
                              ))
                            : eventModel.eventDetails.isEmpty
                                ? const Expanded(
                                    child: Center(
                                      child: Text('No Record Found'),
                                    ),
                                  )
                                : Expanded(
                                    child: GridView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: eventModel.eventDetails.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.1),
                                      ),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 12.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.brown,
                                                    width: 8.0),
                                                color: AppColors.onPrimary),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    'https://www.dharmlok.com/view/${eventModel.eventDetails[index].bannerImageUrl}',
                                                    fit: BoxFit.contain,
                                                    height:
                                                        context.height * 0.2,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      eventModel
                                                          .eventDetails[index]
                                                          .title,
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      'Event Date : ${DateFormat('dd-MM-yyyy').format(eventModel.eventDetails[index].fromDate)}',
                                                      maxLines: 3,
                                                      style: const TextStyle(
                                                          color:
                                                              AppColors.primary,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventDetailPageWidget(
                                                            eventImage: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .bannerImageUrl,
                                                            eventName: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .title,
                                                            toDate: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .toDate,
                                                            fromDate: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .fromDate,
                                                            eventCategory:
                                                                eventModel
                                                                    .eventDetails[
                                                                        index]
                                                                    .category,
                                                            eventAddress:
                                                                eventModel
                                                                    .eventDetails[
                                                                        index]
                                                                    .place,
                                                            eventFees: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .cost,
                                                            fromTime: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .fromTime,
                                                            toTime: eventModel
                                                                .eventDetails[
                                                                    index]
                                                                .toTime,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            backgroundColor:
                                                                Colors.red),
                                                    child: const Text(
                                                      'EXPLORE',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
