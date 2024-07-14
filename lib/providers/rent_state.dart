import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pdfLib;
import 'package:share/share.dart';

import '../controllers/database.dart';
import '../models/customer_model.dart';
import '../models/manager_model.dart';
import '../models/rent_model.dart';
import '../models/vehicles_model.dart';

///Gerencia aluguéis
class RentState extends ChangeNotifier {
  ///Cliente selecionado
  CustomerModel? customerSelected;

  ///Lista de estados do Brasi
  List<String> brazilianStates = [
    'AC',
    'AL',
    'AP',
    'AM',
    'BA',
    'CE',
    'DF',
    'ES',
    'GO',
    'MA',
    'MT',
    'MS',
    'MG',
    'PA',
    'PB',
    'PR',
    'PE',
    'PI',
    'RJ',
    'RN',
    'RS',
    'RO',
    'RR',
    'SC',
    'SP',
    'SE',
    'TO',
  ];

  ///Controladores para os data de inicio
  final startDateController = TextEditingController();

  ///Controladores para os data final
  final endDateController = TextEditingController();

  ///Estado selecionado
  String? stateSelected;

  ///Gerente selecionado
  ManagerModel? managerSelected;

  ///Veículo selecionado
  VehiclesModel? vehicleSelected;

  ///Lista de gerentes do estado selecionado
  List<ManagerModel> managersState = [];

  ///Lista de aluguéis
  final rents = <RentVehicleModel>[];

  ///Tabela de aluguéis
  final tableRents = TableRents();

  ///Data de início do aluguel
  DateTime? startDate;

  ///Data final do aluguel
  DateTime? endDate;

  ///Dias totais do aluguel
  int? totalDays;

  ///Valor do aluguel
  double? rentPrice;

  ///Valor da comissão do gerente
  double? managerCommission;

  ///Inicializa a lista dos aluguéis
  RentState() {
    _initState();
    notifyListeners();
  }

  Future<void> _initState() async {
    rents
      ..clear()
      ..addAll(
        await tableRents.getRents(),
      );
    notifyListeners();
  }

  ///Inicia a lista
  Future<void> init() async {
    await _initState();
  }

  ///Deleta aluguéis
  void deleteRents(RentVehicleModel id) async {
    await tableRents.deleteRents(id);
    rents.remove(id);
    notifyListeners();
  }

  ///Atualiza os aluguéis
  void updateRents(RentVehicleModel id) async {
    await tableRents.updateRents(id);
    notifyListeners();
  }

  ///Pega todos os dados do cliente
  RentVehicleModel getRent() {
    return RentVehicleModel(
      nameCustomer: customerSelected?.name ?? '',
      nameManager: managerSelected?.name ?? '',
      startDate: startDate ?? DateTime.now(),
      finalDate: endDate ?? DateTime.now(),
      plateVehicle: vehicleSelected?.plate ?? '',
      totalDays: totalDays ?? 0,
      rentPrice: getRentPrice().toString(),
      commissionManager: managerCommission ?? 0.0,
    );
  }

  ///Seleciona os gerentes de acordo com o estado
  Future<void> managerByState(String? state) async {
    managerSelected = null;
    managersState.clear();

    if (state != null) {
      final dataBase = await getDatabase();

      final result = await dataBase.query(
        TableManagers.tableName,
        where: '${TableManagers.state} = ?',
        whereArgs: [state],
      );

      for (final item in result) {
        final manager = ManagerModel.fromMapManager(item);
        managersState.add(manager);
      }
    }

    notifyListeners();
  }

  ///Adicionar data de inicio do aluguel
  Future<void> getStartDate(BuildContext context) async {
    var selectedStartDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    if (selectedStartDate != null) {
      startDate = selectedStartDate;
      startDateController.text = '$selectedStartDate'.split(' ')[0];
      notifyListeners();
    }
  }

  ///Adicionar data final do aluguel
  Future<void> getEndDate(BuildContext context) async {
    final selectedEndDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2050),
    );
    if (selectedEndDate != null && selectedEndDate != endDate) {
      endDate = selectedEndDate;
      endDateController.text = '$selectedEndDate'.split(' ')[0];
      _calculateTotalDays();
      notifyListeners();
    }
  }

  void _calculateTotalDays() {
    if (startDate != null && endDate != null) {
      totalDays = endDate!.difference(startDate!).inDays;
    } else {
      totalDays = null;
    }
  }

  ///Calcula o valor do aluguel
  double getRentPrice() {
    rentPrice = (vehicleSelected?.priceDaily ?? 0) * (totalDays ?? 0);
    return rentPrice ?? 0;
  }

  ///Calcula o valor do aluguel
  double getManagerCommission() {
    managerCommission =
        (rentPrice ?? 0) * (managerSelected?.salesCommission ?? 0) / 100;

    return managerCommission ?? 0;
  }

  ///Gera o PDF do comprovante de aluguel
  Future<void> generatePdf(
    CustomerModel customerPdf,
    ManagerModel managerPdf,
    VehiclesModel vehiclePdf,
    RentVehicleModel rentPdf,
  ) async {
    final pdfRent = pdfLib.Document();

    pdfRent.addPage(
      pdfLib.Page(
        build: (context) => pdfLib.Column(
          crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
          children: [
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.center,
              children: [
                pdfLib.Text(
                  'SS Automóveis',
                  style: pdfLib.TextStyle(
                    fontSize: 24,
                    fontWeight: pdfLib.FontWeight.bold,
                  ),
                ),
                pdfLib.SizedBox(height: 10),
                pdfLib.Text(
                  'Comprovante de Aluguel',
                  style: pdfLib.TextStyle(
                    fontSize: 18,
                    fontWeight: pdfLib.FontWeight.normal,
                  ),
                ),
              ],
            ),
            pdfLib.SizedBox(height: 20),
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: [
                pdfLib.Text(
                  'Dados do Cliente:',
                  style: pdfLib.TextStyle(
                    fontWeight: pdfLib.FontWeight.bold,
                  ),
                ),
                pdfLib.SizedBox(height: 10),
                _pdfStyle(
                  'Nome:',
                  customerPdf.name,
                ),
                _pdfStyle(
                  'CNPJ:',
                  customerPdf.cnpj,
                ),
                _pdfStyle(
                  'Telefone:',
                  customerPdf.phone,
                ),
                _pdfStyle(
                  'Endereço:',
                  '${customerPdf.city} - ${customerPdf.state}',
                ),
              ],
            ),
            pdfLib.SizedBox(height: 20),
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: [
                pdfLib.Text(
                  'Dados do Veículo:',
                  style: pdfLib.TextStyle(
                    fontWeight: pdfLib.FontWeight.bold,
                  ),
                ),
                pdfLib.SizedBox(height: 10),
                _pdfStyle(
                  'Placa:',
                  vehiclePdf.plate,
                ),
                _pdfStyle(
                  'Marca:',
                  vehiclePdf.brand,
                ),
                _pdfStyle(
                  'Modelo:',
                  vehiclePdf.model,
                ),
                _pdfStyle(
                  'Ano:',
                  vehiclePdf.manufacturingYear.toString(),
                ),
                _pdfStyle(
                  'Diária:',
                  'R\$ ${vehiclePdf.priceDaily.toStringAsFixed(2)}',
                ),
              ],
            ),
            pdfLib.SizedBox(height: 20),
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: [
                pdfLib.Text(
                  'Dados do Gerente:',
                  style: pdfLib.TextStyle(
                    fontWeight: pdfLib.FontWeight.bold,
                  ),
                ),
                pdfLib.SizedBox(height: 10),
                _pdfStyle(
                  'Nome:',
                  managerPdf.name,
                ),
                _pdfStyle(
                  'CPF:',
                  managerPdf.cpf,
                ),
                _pdfStyle(
                  'Comissão:',
                  '${managerPdf.salesCommission}%',
                ),
                _pdfStyle(
                  'Telefone:',
                  managerPdf.phone,
                ),
                _pdfStyle(
                  'Estado:',
                  managerPdf.state,
                ),
              ],
            ),
            pdfLib.SizedBox(height: 20),
            pdfLib.Column(
              crossAxisAlignment: pdfLib.CrossAxisAlignment.start,
              children: [
                pdfLib.Text(
                  'Período do Aluguel:',
                  style: pdfLib.TextStyle(
                    fontWeight: pdfLib.FontWeight.bold,
                  ),
                ),
                pdfLib.SizedBox(height: 10),
                _pdfStyle(
                  'Início:',
                  DateFormat('dd/MM/yyyy').format(rentPdf.startDate),
                ),
                _pdfStyle(
                  'Término:',
                  DateFormat('dd/MM/yyyy').format(rentPdf.finalDate),
                ),
                _pdfStyle(
                  'Diárias:',
                  rentPdf.totalDays.toString(),
                ),
                _pdfStyle(
                  'Valor Total do Aluguel:',
                  'R\$ ${rentPdf.rentPrice}',
                ),
                _pdfStyle(
                  'Comissão do Gerente:',
                  'R\$ ${rentPdf.commissionManager}',
                ),
              ],
            ),
          ],
        ),
      ),
    );

    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/comprovante_${rentPdf.id}.pdf';
    final file = File(path);
    await file.writeAsBytes(await pdfRent.save());

    Share.shareFiles([path], text: 'Comprovante de Aluguel');
  }

  pdfLib.Widget _pdfStyle(String label, String value) {
    return pdfLib.Container(
      margin: const pdfLib.EdgeInsets.symmetric(vertical: 2),
      child: pdfLib.Row(
        mainAxisAlignment: pdfLib.MainAxisAlignment.spaceBetween,
        children: [
          pdfLib.Text(label),
          pdfLib.Text(value),
        ],
      ),
    );
  }
}
