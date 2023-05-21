import 'package:dharmlok/viewModels/vendor_view_model.dart';
import 'package:dharmlok/views/DharmguruPage/widget/list_container.dart';
import 'package:dharmlok/views/KathavachakPage/widget/kathavachak_list_container.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';

import '../../extensions/device_size.dart';
import 'package:flutter/material.dart';

import '../../helpers/enum.dart';
import '../../viewModels/profile_detail_view_model.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../../widgets/drawer_widget.dart';
import '../BalvidyaPage/balvidya_page_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';
import '../ProfileDetailPage/profile_detail_page.dart';

class KathavachakPageWidget extends StatelessWidget {
  KathavachakPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _dharmguruKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<VendorViewModel>(context, listen: false).getUserLocation();
    Provider.of<VendorViewModel>(context, listen: false)
        .getVendorList('Kathavachak');
    return Consumer<VendorViewModel>(builder: (con, vendorModel, _) {
      return Scaffold(
        key: _dharmguruKey,
        drawer: const DrawerWidget(),
        body: Stack(
          children: [
            const BackgroundImageWidget(),
            const BackgroundOverlayWidget(),
            SafeArea(
              child: Column(
                children: [
                  HomePageAppBarWidget(
                    scaffoldKey: _dharmguruKey,
                    location: vendorModel.userLocation,
                    languageButtonPressed: () {},
                    logoutPressed: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                              AssetImage(AppAssets.kathavachakImageWhite),
                              color: Colors.brown,
                              size: 50,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 12),
                              child: Text(
                                AppStrings.kathavachak,
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
                              onTap: () => vendorModel.updateCategory(
                                  'Sanatan', 'Kathavachak'),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.brown),
                                  color: vendorModel.category == 'Sanatan'
                                      ? Colors.white70
                                      : Colors.white30,
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
                              onTap: () => vendorModel.updateCategory(
                                  'Buddhism', 'Kathavachak'),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.brown),
                                  color: vendorModel.category == 'Buddhism'
                                      ? Colors.white70
                                      : Colors.white30,
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
                              onTap: () => vendorModel.updateCategory(
                                  'Sikh', 'Kathavachak'),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.brown),
                                  color: vendorModel.category == 'Sikh'
                                      ? Colors.white70
                                      : Colors.white30,
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
                              onTap: () => vendorModel.updateCategory(
                                  'Jain', 'Kathavachak'),
                              child: Container(
                                decoration: BoxDecoration(
                                  //border: Border.all(color: Colors.brown),
                                  color: vendorModel.category == 'Jain'
                                      ? Colors.white70
                                      : Colors.white30,
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
                          height: context.height * 0.7,
                          child: vendorModel.status == Status.loading
                              ? const Center(child: CircularProgressIndicator())
                              : vendorModel.status == Status.error
                                  ? Center(
                                      child: Text(
                                      vendorModel.error.message.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 18),
                                    ))
                                  : vendorModel.vendorDetails.isEmpty
                                      ? const Center(
                                          child: Text('No Result Found'))
                                      : SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          child: ListView.builder(
                                            itemCount: vendorModel
                                                .vendorDetails.length,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return KathavachakListContainer(
                                                  profileImage: vendorModel
                                                      .vendorDetails[index]
                                                      .profileImageUrl,
                                                  name: vendorModel
                                                      .vendorDetails[index]
                                                      .name,
                                                  category:
                                                      vendorModel.category,
                                                  onPressed:
                                                      () => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MultiProvider(
                                                                providers: <
                                                                    ChangeNotifierProvider<
                                                                        ProfileDetailViewModel>>[
                                                                  ChangeNotifierProvider<
                                                                          ProfileDetailViewModel>(
                                                                      create: (_) =>
                                                                          ProfileDetailViewModel())
                                                                ],
                                                                child:
                                                                    ProfileDetailPageWidget(
                                                                  id: vendorModel
                                                                      .vendorDetails[
                                                                          index]
                                                                      .id,
                                                                  name: vendorModel
                                                                      .vendorDetails[
                                                                          index]
                                                                      .name,
                                                                  category:
                                                                      'Kathavachak/${vendorModel.vendorDetails[index].category}',
                                                                  profileImageUrl: vendorModel
                                                                      .vendorDetails[
                                                                          index]
                                                                      .profileImageUrl,
                                                                  userType: "0", coverImageUrl: vendorModel
                                                                        .vendorDetails[
                                                                    index]
                                                                        .coverImageUrl,
                                                                ),
                                                              ),
                                                            ),
                                                          ));
                                            },
                                          ),
                                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
