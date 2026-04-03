// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'PetPulse';

  @override
  String get addPet => 'Agregar Mascota';

  @override
  String get editPet => 'Editar Mascota';

  @override
  String get deletePet => 'Eliminar Mascota';

  @override
  String get petName => 'Nombre de la Mascota';

  @override
  String get species => 'Especie';

  @override
  String get breed => 'Raza';

  @override
  String get birthday => 'Fecha de Nacimiento';

  @override
  String get photo => 'Foto';

  @override
  String get notes => 'Notas';

  @override
  String get vaccinations => 'Vacunas';

  @override
  String get medications => 'Medicamentos';

  @override
  String get weight => 'Peso';

  @override
  String get petPassport => 'Pasaporte de Mascota';

  @override
  String get markAsGiven => 'Marcar como Dado';

  @override
  String get dueToday => 'Vence Hoy';

  @override
  String get expired => 'Vencido';

  @override
  String expiresIn(int days) {
    return 'Vence en $days dias';
  }

  @override
  String expiredDaysAgo(int days) {
    return 'Vencido hace $days dias';
  }

  @override
  String get addVaccination => 'Agregar Vacuna';

  @override
  String get editVaccination => 'Editar Vacuna';

  @override
  String get addMedication => 'Agregar Medicamento';

  @override
  String get editMedication => 'Editar Medicamento';

  @override
  String get logWeight => 'Registrar Peso';

  @override
  String get export => 'Exportar';

  @override
  String get share => 'Compartir';

  @override
  String get settings => 'Configuracion';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get overview => 'Resumen';

  @override
  String get vaccinationName => 'Nombre de la Vacuna';

  @override
  String get dateAdministered => 'Fecha de Administracion';

  @override
  String get expirationDate => 'Fecha de Vencimiento';

  @override
  String get vetName => 'Nombre del Veterinario';

  @override
  String get medicationName => 'Nombre del Medicamento';

  @override
  String get dosage => 'Dosis';

  @override
  String get frequency => 'Frecuencia';

  @override
  String get startDate => 'Fecha de Inicio';

  @override
  String get endDate => 'Fecha de Fin';

  @override
  String get daily => 'Diario';

  @override
  String get weekly => 'Semanal';

  @override
  String get monthly => 'Mensual';

  @override
  String get weightKg => 'Peso (kg)';

  @override
  String get date => 'Fecha';

  @override
  String get noPets => 'Sin mascotas aun. Agrega tu primera mascota!';

  @override
  String get noVaccinations => 'Sin vacunas registradas.';

  @override
  String get noMedications => 'Sin medicamentos registrados.';

  @override
  String get noWeightEntries => 'Sin registros de peso aun.';

  @override
  String deleteConfirmTitle(String name) {
    return 'Eliminar $name?';
  }

  @override
  String get deleteConfirmMessage => 'Esta accion no se puede deshacer.';

  @override
  String get premium => 'Premium';

  @override
  String get upgradeToPremium => 'Actualizar a Premium';

  @override
  String get premiumDescription =>
      'Mascotas ilimitadas, exportacion de pasaporte PDF, recordatorios de medicamentos';

  @override
  String get premiumPrice => '\$14.99 pago unico';

  @override
  String get restorePurchases => 'Restaurar Compras';

  @override
  String get purchaseSuccess => 'Compra exitosa!';

  @override
  String get purchaseError => 'Compra fallida. Por favor intenta de nuevo.';

  @override
  String get freeTierLimit =>
      'El plan gratuito permite 1 mascota. Actualiza a Premium para mascotas ilimitadas.';

  @override
  String get premiumFeature => 'Esta es una funcion Premium.';

  @override
  String get weightTrend => 'Tendencia de Peso';

  @override
  String get generatePassport => 'Generar Pasaporte';

  @override
  String get sharePassport => 'Compartir Pasaporte';

  @override
  String get printPassport => 'Imprimir Pasaporte';

  @override
  String get petInformation => 'Informacion de la Mascota';

  @override
  String get currentMedications => 'Medicamentos Actuales';

  @override
  String get latestWeight => 'Ultimo Peso';

  @override
  String get generatedBy => 'Generado por PetPulse';

  @override
  String get dog => 'Perro';

  @override
  String get cat => 'Gato';

  @override
  String get bird => 'Ave';

  @override
  String get rabbit => 'Conejo';

  @override
  String get other => 'Otro';

  @override
  String get selectSpecies => 'Seleccionar Especie';

  @override
  String get selectDate => 'Seleccionar Fecha';

  @override
  String get selectFrequency => 'Seleccionar Frecuencia';

  @override
  String get fieldRequired => 'Este campo es obligatorio';

  @override
  String get age => 'Edad';

  @override
  String years(int count) {
    return '$count anios';
  }

  @override
  String months(int count) {
    return '$count meses';
  }

  @override
  String get weightUnit => 'kg';

  @override
  String get medicationReminder => 'Recordatorio de Medicamento';

  @override
  String medicationReminderBody(String petName, String medicationName) {
    return 'Es hora de darle a $petName su $medicationName';
  }

  @override
  String get vaccinationExpiring => 'Vacuna por Vencer';

  @override
  String vaccinationExpiringBody(
    String petName,
    String vaccinationName,
    int days,
  ) {
    return 'La vacuna $vaccinationName de $petName vence en $days dias';
  }

  @override
  String vaccinationExpiredBody(String petName, String vaccinationName) {
    return 'La vacuna $vaccinationName de $petName ha vencido!';
  }

  @override
  String get markedAsGiven => 'Marcado como dado';

  @override
  String get allPets => 'Todas las Mascotas';

  @override
  String get tapToAdd => 'Toca + para agregar tu primera mascota';

  @override
  String get choosePhoto => 'Elegir Foto';

  @override
  String get takePhoto => 'Tomar Foto';

  @override
  String get removePhoto => 'Eliminar Foto';

  @override
  String get aboutApp => 'Acerca de PetPulse';

  @override
  String get aboutDescription =>
      'PetPulse te ayuda a llevar un registro de la salud, vacunas y medicamentos de tu mascota en un solo lugar.';

  @override
  String get version => 'Version';

  @override
  String get publisher => 'Heldig Lab';

  @override
  String get microchipId => 'ID de Microchip';

  @override
  String get dueMedications => 'Medicamentos Pendientes';

  @override
  String get upcomingVaccinations => 'Vacunas Proximas';

  @override
  String get freeMedicationLimit =>
      'La version gratuita permite 3 medicamentos. Actualiza a Premium para ilimitados.';

  @override
  String get weightLbs => 'Peso (lbs)';
}
