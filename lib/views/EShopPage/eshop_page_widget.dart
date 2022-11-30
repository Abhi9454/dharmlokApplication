import 'package:dharmlok/constants/AppColors.dart';
import 'package:dharmlok/extensions/device_size.dart';
import 'package:dharmlok/viewModels/eshop_view_model.dart';
import 'package:dharmlok/views/ProductDetailPage/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppAssets.dart';
import '../../constants/AppStrings.dart';
import '../../helpers/enum.dart';
import '../../widgets/background_image_widget.dart';
import '../../widgets/background_overlay_widget.dart';
import '../HomePage/components/home_appbar_widget.dart';

class EShopPageWidget extends StatelessWidget {
  EShopPageWidget({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _eshopKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Provider.of<EshopViewModel>(context, listen: false).getUserLocation();
    Provider.of<EshopViewModel>(context, listen: false).getAllProducts();
    return Consumer<EshopViewModel>(builder: (con, eshopModel, _) {
      return Scaffold(
        key: _eshopKey,
        body: SafeArea(
          child: Stack(
            children: [
              const BackgroundImageWidget(),
              const BackgroundOverlayWidget(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HomePageAppBarWidget(
                    scaffoldKey: _eshopKey,
                    location: eshopModel.userLocation,
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
                        AssetImage(AppAssets.eshopImageWhite),
                        color: Colors.brown,
                        size: 50,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text(
                          AppStrings.eshop,
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
                  eshopModel.status == Status.loading
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : eshopModel.status == Status.error
                          ? Center(
                              child: Text(
                              eshopModel.error.message.toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 18),
                            ))
                          : eshopModel.productList.isEmpty
                              ? const Expanded(
                                  child: Center(
                                    child: Text('No Record Found'),
                                  ),
                                )
                              : Expanded(
                                  child: GridView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: eshopModel.productList.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.3),
                                    ),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return InkWell(
                                        onTap: () {
                                          eshopModel.getProfileDetails(
                                              eshopModel
                                                  .productList[index].userId);
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductDetailPageWidget(
                                                productName: eshopModel
                                                    .productList[index].title,
                                                productPrice: eshopModel
                                                    .productList[index].price
                                                    .toString(),
                                                productImage: eshopModel
                                                    .productList[index]
                                                    .imageUrl,
                                                category: eshopModel
                                                    .productList[index]
                                                    .category,
                                                availability: eshopModel
                                                    .productList[index].quantity
                                                    .toString(),
                                                vendorName:
                                                    eshopModel.vendorName,
                                                vendorPhone: eshopModel
                                                    .vendorPhoneNumber,
                                                productId: eshopModel
                                                    .productList[index].id
                                                    .toString(), userLocation: eshopModel.userLocation,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0,
                                              right: 8.0,
                                              bottom: 12.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              // border: Border.all(
                                              //     color: Colors.brown,
                                              //     width: 8.0),
                                                borderRadius: BorderRadius.circular(10.0),
                                                color: Colors.white70),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                children: [
                                                  Image.network(
                                                    '${AppStrings.imageUrl}${eshopModel.productList[index].imageUrl}',
                                                    fit: BoxFit.cover,
                                                    height:
                                                        context.height * 0.2,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      eshopModel
                                                          .productList[index]
                                                          .title,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black,
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
                                                      '₹${eshopModel.productList[index].price.toString()}',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color:
                                                              Colors.black,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
    });
  }
}
