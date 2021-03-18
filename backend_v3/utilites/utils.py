from crud.database import SessionLocal

db = SessionLocal()


def fill_base_with_objects(models_list_to_insert, db_model, field_name: str,
                           db,
                           by_full_string=False,
                           full_string_keys=[]):
    # by_full_string - ищем по целой строке

    # добываем все модели из базы
    models_list_from_base = db.query(db_model).all()
    print(f"взято моделей {db_model} из базы: {len(models_list_from_base)}")
    clear_models = []

    if by_full_string:
        #     for index, model_to_insert in enumerate(models_list_to_insert):
        print(by_full_string)
        print(full_string_keys)

        in_base_strings = []
        clear_models = []

        for index, model_from_base in enumerate(models_list_from_base):
            in_base_strings.append(
                f"{getattr(model_from_base, full_string_keys[0])}_{getattr(model_from_base, full_string_keys[1])}")

        for index, model_to_insert in enumerate(models_list_to_insert):
            check_string = f"{getattr(model_to_insert, full_string_keys[0])}_{getattr(model_to_insert, full_string_keys[1])}"
            if not(check_string in in_base_strings):
                clear_models.append(model_to_insert)

    else:
        # формируем словарь
        all_from_base_dict = {getattr(k, field_name, ""): getattr(
            k, field_name, "") for k in models_list_from_base}

        clear_models = [l for l in models_list_to_insert if not (
            getattr(l, field_name, "") in all_from_base_dict)]

    print(
        f"очищенные модели {db_model} для передачи в базу: {len(clear_models)}")

    db.add_all(clear_models)
    db.commit()
