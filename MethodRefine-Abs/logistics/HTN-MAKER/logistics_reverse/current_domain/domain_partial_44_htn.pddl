( define ( domain logistics )
  ( :requirements :strips :typing :equality :htn )
  ( :types airplane city location obj truck )
  ( :predicates
    ( OBJ-AT ?a - OBJ ?b - LOCATION )
    ( TRUCK-AT ?c - TRUCK ?d - LOCATION )
    ( AIRPLANE-AT ?e - AIRPLANE ?f - LOCATION )
    ( IN-TRUCK ?g - OBJ ?h - TRUCK )
    ( IN-AIRPLANE ?i - OBJ ?j - AIRPLANE )
    ( IN-CITY ?k - LOCATION ?l - CITY )
    ( AIRPORT ?o - LOCATION )
  )
  ( :action !LOAD-TRUCK
    :parameters
    (
      ?obj - OBJ
      ?truck - TRUCK
      ?loc - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?truck ?loc ) ( OBJ-AT ?obj ?loc ) )
    :effect
    ( and ( not ( OBJ-AT ?obj ?loc ) ) ( IN-TRUCK ?obj ?truck ) )
  )
  ( :action !LOAD-AIRPLANE
    :parameters
    (
      ?obj - OBJ
      ?airplane - AIRPLANE
      ?loc - LOCATION
    )
    :precondition
    ( and ( OBJ-AT ?obj ?loc ) ( AIRPLANE-AT ?airplane ?loc ) )
    :effect
    ( and ( not ( OBJ-AT ?obj ?loc ) ) ( IN-AIRPLANE ?obj ?airplane ) )
  )
  ( :action !UNLOAD-TRUCK
    :parameters
    (
      ?obj - OBJ
      ?truck - TRUCK
      ?loc - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?truck ?loc ) ( IN-TRUCK ?obj ?truck ) )
    :effect
    ( and ( not ( IN-TRUCK ?obj ?truck ) ) ( OBJ-AT ?obj ?loc ) )
  )
  ( :action !UNLOAD-AIRPLANE
    :parameters
    (
      ?obj - OBJ
      ?airplane - AIRPLANE
      ?loc - LOCATION
    )
    :precondition
    ( and ( IN-AIRPLANE ?obj ?airplane ) ( AIRPLANE-AT ?airplane ?loc ) )
    :effect
    ( and ( not ( IN-AIRPLANE ?obj ?airplane ) ) ( OBJ-AT ?obj ?loc ) )
  )
  ( :action !DRIVE-TRUCK
    :parameters
    (
      ?truck - TRUCK
      ?loc-from - LOCATION
      ?loc-to - LOCATION
      ?city - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?truck ?loc-from ) ( IN-CITY ?loc-from ?city ) ( IN-CITY ?loc-to ?city ) ( not ( = ?loc-from ?loc-to ) ) )
    :effect
    ( and ( not ( TRUCK-AT ?truck ?loc-from ) ) ( TRUCK-AT ?truck ?loc-to ) )
  )
  ( :action !FLY-AIRPLANE
    :parameters
    (
      ?airplane - AIRPLANE
      ?loc-from - LOCATION
      ?loc-to - LOCATION
    )
    :precondition
    ( and ( AIRPORT ?loc-from ) ( AIRPORT ?loc-to ) ( AIRPLANE-AT ?airplane ?loc-from ) ( not ( = ?loc-from ?loc-to ) ) )
    :effect
    ( and ( not ( AIRPLANE-AT ?airplane ?loc-from ) ) ( AIRPLANE-AT ?airplane ?loc-to ) )
  )
  ( :method DELIVER-PKG
    :parameters
    (
      ?obj - OBJ
      ?dst - LOCATION
    )
    :precondition
    ( and ( OBJ-AT ?obj ?dst ) )
    :subtasks
    (  )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_2 - OBJ
      ?auto_3 - LOCATION
    )
    :vars
    (
      ?auto_4 - TRUCK
    )
    :precondition
    ( and ( TRUCK-AT ?auto_4 ?auto_3 ) ( IN-TRUCK ?auto_2 ?auto_4 ) )
    :subtasks
    ( ( !UNLOAD-TRUCK ?auto_2 ?auto_4 ?auto_3 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_7 - OBJ
      ?auto_8 - LOCATION
    )
    :vars
    (
      ?auto_11 - TRUCK
      ?auto_13 - LOCATION
      ?auto_14 - CITY
    )
    :precondition
    ( and ( IN-TRUCK ?auto_7 ?auto_11 ) ( TRUCK-AT ?auto_11 ?auto_13 ) ( IN-CITY ?auto_13 ?auto_14 ) ( IN-CITY ?auto_8 ?auto_14 ) ( not ( = ?auto_8 ?auto_13 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_11 ?auto_13 ?auto_8 ?auto_14 )
      ( DELIVER-PKG ?auto_7 ?auto_8 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_16 - OBJ
      ?auto_17 - LOCATION
    )
    :vars
    (
      ?auto_20 - TRUCK
      ?auto_22 - LOCATION
      ?auto_21 - CITY
      ?auto_24 - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?auto_20 ?auto_22 ) ( IN-CITY ?auto_22 ?auto_21 ) ( IN-CITY ?auto_17 ?auto_21 ) ( not ( = ?auto_17 ?auto_22 ) ) ( TRUCK-AT ?auto_20 ?auto_24 ) ( OBJ-AT ?auto_16 ?auto_24 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_16 ?auto_20 ?auto_24 )
      ( DELIVER-PKG ?auto_16 ?auto_17 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_782 - OBJ
      ?auto_783 - LOCATION
    )
    :vars
    (
      ?auto_790 - LOCATION
      ?auto_786 - CITY
      ?auto_785 - LOCATION
      ?auto_787 - CITY
      ?auto_792 - LOCATION
      ?auto_791 - CITY
      ?auto_788 - TRUCK
      ?auto_794 - LOCATION
      ?auto_795 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_790 ?auto_786 ) ( IN-CITY ?auto_783 ?auto_786 ) ( not ( = ?auto_783 ?auto_790 ) ) ( OBJ-AT ?auto_782 ?auto_790 ) ( IN-CITY ?auto_785 ?auto_787 ) ( IN-CITY ?auto_790 ?auto_787 ) ( not ( = ?auto_790 ?auto_785 ) ) ( IN-CITY ?auto_792 ?auto_791 ) ( IN-CITY ?auto_785 ?auto_791 ) ( not ( = ?auto_785 ?auto_792 ) ) ( TRUCK-AT ?auto_788 ?auto_794 ) ( IN-CITY ?auto_794 ?auto_795 ) ( IN-CITY ?auto_792 ?auto_795 ) ( not ( = ?auto_792 ?auto_794 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_788 ?auto_794 ?auto_792 ?auto_795 )
      ( DELIVER-PKG ?auto_782 ?auto_783 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_40 - OBJ
      ?auto_41 - LOCATION
    )
    :vars
    (
      ?auto_44 - AIRPLANE
    )
    :precondition
    ( and ( IN-AIRPLANE ?auto_40 ?auto_44 ) ( AIRPLANE-AT ?auto_44 ?auto_41 ) )
    :subtasks
    ( ( !UNLOAD-AIRPLANE ?auto_40 ?auto_44 ?auto_41 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_45 - OBJ
      ?auto_46 - LOCATION
    )
    :vars
    (
      ?auto_49 - AIRPLANE
      ?auto_51 - LOCATION
    )
    :precondition
    ( and ( IN-AIRPLANE ?auto_45 ?auto_49 ) ( AIRPORT ?auto_51 ) ( AIRPORT ?auto_46 ) ( AIRPLANE-AT ?auto_49 ?auto_51 ) ( not ( = ?auto_51 ?auto_46 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_49 ?auto_51 ?auto_46 )
      ( DELIVER-PKG ?auto_45 ?auto_46 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_53 - OBJ
      ?auto_54 - LOCATION
    )
    :vars
    (
      ?auto_57 - LOCATION
      ?auto_55 - AIRPLANE
      ?auto_59 - LOCATION
    )
    :precondition
    ( and ( AIRPORT ?auto_57 ) ( AIRPORT ?auto_54 ) ( AIRPLANE-AT ?auto_55 ?auto_57 ) ( not ( = ?auto_57 ?auto_54 ) ) ( OBJ-AT ?auto_53 ?auto_59 ) ( AIRPLANE-AT ?auto_55 ?auto_59 ) )
    :subtasks
    ( ( !LOAD-AIRPLANE ?auto_53 ?auto_55 ?auto_59 )
      ( DELIVER-PKG ?auto_53 ?auto_54 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_4965 - OBJ
      ?auto_4966 - LOCATION
    )
    :vars
    (
      ?auto_4976 - LOCATION
      ?auto_4969 - LOCATION
      ?auto_4967 - LOCATION
      ?auto_4972 - LOCATION
      ?auto_4971 - LOCATION
      ?auto_4968 - LOCATION
      ?auto_4974 - LOCATION
      ?auto_4978 - LOCATION
      ?auto_4970 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_4976 ) ( AIRPORT ?auto_4966 ) ( not ( = ?auto_4976 ?auto_4966 ) ) ( OBJ-AT ?auto_4965 ?auto_4976 ) ( AIRPORT ?auto_4969 ) ( not ( = ?auto_4969 ?auto_4976 ) ) ( AIRPORT ?auto_4967 ) ( not ( = ?auto_4967 ?auto_4969 ) ) ( AIRPORT ?auto_4972 ) ( not ( = ?auto_4972 ?auto_4967 ) ) ( AIRPORT ?auto_4971 ) ( not ( = ?auto_4971 ?auto_4972 ) ) ( AIRPORT ?auto_4968 ) ( not ( = ?auto_4968 ?auto_4971 ) ) ( AIRPORT ?auto_4974 ) ( not ( = ?auto_4974 ?auto_4968 ) ) ( AIRPORT ?auto_4978 ) ( AIRPLANE-AT ?auto_4970 ?auto_4978 ) ( not ( = ?auto_4978 ?auto_4974 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_4970 ?auto_4978 ?auto_4974 )
      ( DELIVER-PKG ?auto_4965 ?auto_4966 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_72 - OBJ
      ?auto_73 - LOCATION
    )
    :vars
    (
      ?auto_74 - LOCATION
      ?auto_76 - LOCATION
      ?auto_75 - AIRPLANE
      ?auto_81 - TRUCK
    )
    :precondition
    ( and ( AIRPORT ?auto_74 ) ( AIRPORT ?auto_73 ) ( not ( = ?auto_74 ?auto_73 ) ) ( AIRPORT ?auto_76 ) ( AIRPLANE-AT ?auto_75 ?auto_76 ) ( not ( = ?auto_76 ?auto_74 ) ) ( TRUCK-AT ?auto_81 ?auto_74 ) ( IN-TRUCK ?auto_72 ?auto_81 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_72 ?auto_74 )
      ( DELIVER-PKG ?auto_72 ?auto_73 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_82 - OBJ
      ?auto_83 - LOCATION
    )
    :vars
    (
      ?auto_87 - LOCATION
      ?auto_86 - LOCATION
      ?auto_88 - AIRPLANE
      ?auto_89 - TRUCK
      ?auto_91 - LOCATION
      ?auto_92 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_87 ) ( AIRPORT ?auto_83 ) ( not ( = ?auto_87 ?auto_83 ) ) ( AIRPORT ?auto_86 ) ( AIRPLANE-AT ?auto_88 ?auto_86 ) ( not ( = ?auto_86 ?auto_87 ) ) ( IN-TRUCK ?auto_82 ?auto_89 ) ( TRUCK-AT ?auto_89 ?auto_91 ) ( IN-CITY ?auto_91 ?auto_92 ) ( IN-CITY ?auto_87 ?auto_92 ) ( not ( = ?auto_87 ?auto_91 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_89 ?auto_91 ?auto_87 ?auto_92 )
      ( DELIVER-PKG ?auto_82 ?auto_83 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_94 - OBJ
      ?auto_95 - LOCATION
    )
    :vars
    (
      ?auto_99 - LOCATION
      ?auto_100 - LOCATION
      ?auto_98 - AIRPLANE
      ?auto_96 - TRUCK
      ?auto_102 - LOCATION
      ?auto_103 - CITY
      ?auto_105 - LOCATION
    )
    :precondition
    ( and ( AIRPORT ?auto_99 ) ( AIRPORT ?auto_95 ) ( not ( = ?auto_99 ?auto_95 ) ) ( AIRPORT ?auto_100 ) ( AIRPLANE-AT ?auto_98 ?auto_100 ) ( not ( = ?auto_100 ?auto_99 ) ) ( TRUCK-AT ?auto_96 ?auto_102 ) ( IN-CITY ?auto_102 ?auto_103 ) ( IN-CITY ?auto_99 ?auto_103 ) ( not ( = ?auto_99 ?auto_102 ) ) ( TRUCK-AT ?auto_96 ?auto_105 ) ( OBJ-AT ?auto_94 ?auto_105 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_94 ?auto_96 ?auto_105 )
      ( DELIVER-PKG ?auto_94 ?auto_95 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_8455 - OBJ
      ?auto_8456 - LOCATION
    )
    :vars
    (
      ?auto_8462 - LOCATION
      ?auto_8467 - LOCATION
      ?auto_8465 - LOCATION
      ?auto_8459 - CITY
      ?auto_8464 - LOCATION
      ?auto_8466 - LOCATION
      ?auto_8461 - AIRPLANE
      ?auto_8463 - TRUCK
      ?auto_8469 - LOCATION
      ?auto_8470 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_8462 ) ( AIRPORT ?auto_8456 ) ( not ( = ?auto_8462 ?auto_8456 ) ) ( AIRPORT ?auto_8467 ) ( not ( = ?auto_8467 ?auto_8462 ) ) ( IN-CITY ?auto_8465 ?auto_8459 ) ( IN-CITY ?auto_8462 ?auto_8459 ) ( not ( = ?auto_8462 ?auto_8465 ) ) ( OBJ-AT ?auto_8455 ?auto_8465 ) ( AIRPORT ?auto_8464 ) ( not ( = ?auto_8464 ?auto_8467 ) ) ( AIRPORT ?auto_8466 ) ( AIRPLANE-AT ?auto_8461 ?auto_8466 ) ( not ( = ?auto_8466 ?auto_8464 ) ) ( TRUCK-AT ?auto_8463 ?auto_8469 ) ( IN-CITY ?auto_8469 ?auto_8470 ) ( IN-CITY ?auto_8465 ?auto_8470 ) ( not ( = ?auto_8465 ?auto_8469 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_8463 ?auto_8469 ?auto_8465 ?auto_8470 )
      ( DELIVER-PKG ?auto_8455 ?auto_8456 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_148 - OBJ
      ?auto_149 - LOCATION
    )
    :vars
    (
      ?auto_153 - TRUCK
      ?auto_150 - LOCATION
      ?auto_155 - CITY
      ?auto_152 - LOCATION
      ?auto_158 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_153 ?auto_150 ) ( IN-CITY ?auto_150 ?auto_155 ) ( IN-CITY ?auto_149 ?auto_155 ) ( not ( = ?auto_149 ?auto_150 ) ) ( TRUCK-AT ?auto_153 ?auto_152 ) ( IN-AIRPLANE ?auto_148 ?auto_158 ) ( AIRPLANE-AT ?auto_158 ?auto_152 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_148 ?auto_152 )
      ( DELIVER-PKG ?auto_148 ?auto_149 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_159 - OBJ
      ?auto_160 - LOCATION
    )
    :vars
    (
      ?auto_163 - TRUCK
      ?auto_167 - LOCATION
      ?auto_164 - CITY
      ?auto_166 - LOCATION
      ?auto_161 - AIRPLANE
      ?auto_169 - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?auto_163 ?auto_167 ) ( IN-CITY ?auto_167 ?auto_164 ) ( IN-CITY ?auto_160 ?auto_164 ) ( not ( = ?auto_160 ?auto_167 ) ) ( TRUCK-AT ?auto_163 ?auto_166 ) ( IN-AIRPLANE ?auto_159 ?auto_161 ) ( AIRPORT ?auto_169 ) ( AIRPORT ?auto_166 ) ( AIRPLANE-AT ?auto_161 ?auto_169 ) ( not ( = ?auto_169 ?auto_166 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_161 ?auto_169 ?auto_166 )
      ( DELIVER-PKG ?auto_159 ?auto_160 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_171 - OBJ
      ?auto_172 - LOCATION
    )
    :vars
    (
      ?auto_173 - TRUCK
      ?auto_174 - LOCATION
      ?auto_180 - CITY
      ?auto_177 - LOCATION
      ?auto_179 - LOCATION
      ?auto_178 - AIRPLANE
      ?auto_181 - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?auto_173 ?auto_174 ) ( IN-CITY ?auto_174 ?auto_180 ) ( IN-CITY ?auto_172 ?auto_180 ) ( not ( = ?auto_172 ?auto_174 ) ) ( TRUCK-AT ?auto_173 ?auto_177 ) ( AIRPORT ?auto_179 ) ( AIRPORT ?auto_177 ) ( AIRPLANE-AT ?auto_178 ?auto_179 ) ( not ( = ?auto_179 ?auto_177 ) ) ( OBJ-AT ?auto_171 ?auto_181 ) ( AIRPLANE-AT ?auto_178 ?auto_181 ) )
    :subtasks
    ( ( !LOAD-AIRPLANE ?auto_171 ?auto_178 ?auto_181 )
      ( DELIVER-PKG ?auto_171 ?auto_172 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_7457 - OBJ
      ?auto_7458 - LOCATION
    )
    :vars
    (
      ?auto_7459 - TRUCK
      ?auto_7462 - LOCATION
      ?auto_7467 - CITY
      ?auto_7464 - LOCATION
      ?auto_7461 - LOCATION
      ?auto_7465 - LOCATION
      ?auto_7463 - LOCATION
      ?auto_7468 - LOCATION
      ?auto_7466 - LOCATION
      ?auto_7472 - LOCATION
      ?auto_7460 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_7459 ?auto_7462 ) ( IN-CITY ?auto_7462 ?auto_7467 ) ( IN-CITY ?auto_7458 ?auto_7467 ) ( not ( = ?auto_7458 ?auto_7462 ) ) ( TRUCK-AT ?auto_7459 ?auto_7464 ) ( AIRPORT ?auto_7461 ) ( AIRPORT ?auto_7464 ) ( not ( = ?auto_7461 ?auto_7464 ) ) ( OBJ-AT ?auto_7457 ?auto_7461 ) ( AIRPORT ?auto_7465 ) ( not ( = ?auto_7465 ?auto_7461 ) ) ( AIRPORT ?auto_7463 ) ( not ( = ?auto_7463 ?auto_7465 ) ) ( AIRPORT ?auto_7468 ) ( not ( = ?auto_7468 ?auto_7463 ) ) ( AIRPORT ?auto_7466 ) ( not ( = ?auto_7466 ?auto_7468 ) ) ( AIRPORT ?auto_7472 ) ( AIRPLANE-AT ?auto_7460 ?auto_7472 ) ( not ( = ?auto_7472 ?auto_7466 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_7460 ?auto_7472 ?auto_7466 )
      ( DELIVER-PKG ?auto_7457 ?auto_7458 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_198 - OBJ
      ?auto_199 - LOCATION
    )
    :vars
    (
      ?auto_202 - TRUCK
      ?auto_203 - LOCATION
      ?auto_206 - CITY
      ?auto_204 - LOCATION
      ?auto_205 - LOCATION
      ?auto_208 - LOCATION
      ?auto_207 - AIRPLANE
      ?auto_211 - TRUCK
    )
    :precondition
    ( and ( TRUCK-AT ?auto_202 ?auto_203 ) ( IN-CITY ?auto_203 ?auto_206 ) ( IN-CITY ?auto_199 ?auto_206 ) ( not ( = ?auto_199 ?auto_203 ) ) ( TRUCK-AT ?auto_202 ?auto_204 ) ( AIRPORT ?auto_205 ) ( AIRPORT ?auto_204 ) ( not ( = ?auto_205 ?auto_204 ) ) ( AIRPORT ?auto_208 ) ( AIRPLANE-AT ?auto_207 ?auto_208 ) ( not ( = ?auto_208 ?auto_205 ) ) ( TRUCK-AT ?auto_211 ?auto_205 ) ( IN-TRUCK ?auto_198 ?auto_211 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_198 ?auto_205 )
      ( DELIVER-PKG ?auto_198 ?auto_199 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_212 - OBJ
      ?auto_213 - LOCATION
    )
    :vars
    (
      ?auto_217 - TRUCK
      ?auto_215 - LOCATION
      ?auto_222 - CITY
      ?auto_220 - LOCATION
      ?auto_223 - LOCATION
      ?auto_221 - LOCATION
      ?auto_219 - AIRPLANE
      ?auto_218 - TRUCK
      ?auto_225 - LOCATION
      ?auto_226 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_217 ?auto_215 ) ( IN-CITY ?auto_215 ?auto_222 ) ( IN-CITY ?auto_213 ?auto_222 ) ( not ( = ?auto_213 ?auto_215 ) ) ( TRUCK-AT ?auto_217 ?auto_220 ) ( AIRPORT ?auto_223 ) ( AIRPORT ?auto_220 ) ( not ( = ?auto_223 ?auto_220 ) ) ( AIRPORT ?auto_221 ) ( AIRPLANE-AT ?auto_219 ?auto_221 ) ( not ( = ?auto_221 ?auto_223 ) ) ( IN-TRUCK ?auto_212 ?auto_218 ) ( TRUCK-AT ?auto_218 ?auto_225 ) ( IN-CITY ?auto_225 ?auto_226 ) ( IN-CITY ?auto_223 ?auto_226 ) ( not ( = ?auto_223 ?auto_225 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_218 ?auto_225 ?auto_223 ?auto_226 )
      ( DELIVER-PKG ?auto_212 ?auto_213 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_228 - OBJ
      ?auto_229 - LOCATION
    )
    :vars
    (
      ?auto_239 - TRUCK
      ?auto_231 - LOCATION
      ?auto_238 - CITY
      ?auto_235 - LOCATION
      ?auto_234 - LOCATION
      ?auto_236 - LOCATION
      ?auto_237 - AIRPLANE
      ?auto_230 - TRUCK
      ?auto_240 - LOCATION
      ?auto_241 - CITY
      ?auto_243 - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?auto_239 ?auto_231 ) ( IN-CITY ?auto_231 ?auto_238 ) ( IN-CITY ?auto_229 ?auto_238 ) ( not ( = ?auto_229 ?auto_231 ) ) ( TRUCK-AT ?auto_239 ?auto_235 ) ( AIRPORT ?auto_234 ) ( AIRPORT ?auto_235 ) ( not ( = ?auto_234 ?auto_235 ) ) ( AIRPORT ?auto_236 ) ( AIRPLANE-AT ?auto_237 ?auto_236 ) ( not ( = ?auto_236 ?auto_234 ) ) ( TRUCK-AT ?auto_230 ?auto_240 ) ( IN-CITY ?auto_240 ?auto_241 ) ( IN-CITY ?auto_234 ?auto_241 ) ( not ( = ?auto_234 ?auto_240 ) ) ( TRUCK-AT ?auto_230 ?auto_243 ) ( OBJ-AT ?auto_228 ?auto_243 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_228 ?auto_230 ?auto_243 )
      ( DELIVER-PKG ?auto_228 ?auto_229 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_245 - OBJ
      ?auto_246 - LOCATION
    )
    :vars
    (
      ?auto_252 - TRUCK
      ?auto_258 - LOCATION
      ?auto_254 - CITY
      ?auto_255 - LOCATION
      ?auto_249 - LOCATION
      ?auto_256 - LOCATION
      ?auto_253 - AIRPLANE
      ?auto_259 - LOCATION
      ?auto_250 - CITY
      ?auto_257 - TRUCK
      ?auto_261 - LOCATION
      ?auto_262 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_252 ?auto_258 ) ( IN-CITY ?auto_258 ?auto_254 ) ( IN-CITY ?auto_246 ?auto_254 ) ( not ( = ?auto_246 ?auto_258 ) ) ( TRUCK-AT ?auto_252 ?auto_255 ) ( AIRPORT ?auto_249 ) ( AIRPORT ?auto_255 ) ( not ( = ?auto_249 ?auto_255 ) ) ( AIRPORT ?auto_256 ) ( AIRPLANE-AT ?auto_253 ?auto_256 ) ( not ( = ?auto_256 ?auto_249 ) ) ( IN-CITY ?auto_259 ?auto_250 ) ( IN-CITY ?auto_249 ?auto_250 ) ( not ( = ?auto_249 ?auto_259 ) ) ( OBJ-AT ?auto_245 ?auto_259 ) ( TRUCK-AT ?auto_257 ?auto_261 ) ( IN-CITY ?auto_261 ?auto_262 ) ( IN-CITY ?auto_259 ?auto_262 ) ( not ( = ?auto_259 ?auto_261 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_257 ?auto_261 ?auto_259 ?auto_262 )
      ( DELIVER-PKG ?auto_245 ?auto_246 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_415 - OBJ
      ?auto_416 - LOCATION
    )
    :vars
    (
      ?auto_418 - LOCATION
      ?auto_417 - AIRPLANE
      ?auto_421 - LOCATION
      ?auto_423 - TRUCK
    )
    :precondition
    ( and ( AIRPORT ?auto_418 ) ( AIRPORT ?auto_416 ) ( AIRPLANE-AT ?auto_417 ?auto_418 ) ( not ( = ?auto_418 ?auto_416 ) ) ( AIRPLANE-AT ?auto_417 ?auto_421 ) ( TRUCK-AT ?auto_423 ?auto_421 ) ( IN-TRUCK ?auto_415 ?auto_423 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_415 ?auto_421 )
      ( DELIVER-PKG ?auto_415 ?auto_416 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_425 - OBJ
      ?auto_426 - LOCATION
    )
    :vars
    (
      ?auto_432 - LOCATION
      ?auto_431 - AIRPLANE
      ?auto_429 - LOCATION
      ?auto_427 - TRUCK
      ?auto_434 - LOCATION
      ?auto_435 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_432 ) ( AIRPORT ?auto_426 ) ( AIRPLANE-AT ?auto_431 ?auto_432 ) ( not ( = ?auto_432 ?auto_426 ) ) ( AIRPLANE-AT ?auto_431 ?auto_429 ) ( IN-TRUCK ?auto_425 ?auto_427 ) ( TRUCK-AT ?auto_427 ?auto_434 ) ( IN-CITY ?auto_434 ?auto_435 ) ( IN-CITY ?auto_429 ?auto_435 ) ( not ( = ?auto_429 ?auto_434 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_427 ?auto_434 ?auto_429 ?auto_435 )
      ( DELIVER-PKG ?auto_425 ?auto_426 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_437 - OBJ
      ?auto_438 - LOCATION
    )
    :vars
    (
      ?auto_445 - LOCATION
      ?auto_442 - AIRPLANE
      ?auto_444 - LOCATION
      ?auto_439 - TRUCK
      ?auto_446 - LOCATION
      ?auto_443 - CITY
      ?auto_448 - LOCATION
    )
    :precondition
    ( and ( AIRPORT ?auto_445 ) ( AIRPORT ?auto_438 ) ( AIRPLANE-AT ?auto_442 ?auto_445 ) ( not ( = ?auto_445 ?auto_438 ) ) ( AIRPLANE-AT ?auto_442 ?auto_444 ) ( TRUCK-AT ?auto_439 ?auto_446 ) ( IN-CITY ?auto_446 ?auto_443 ) ( IN-CITY ?auto_444 ?auto_443 ) ( not ( = ?auto_444 ?auto_446 ) ) ( TRUCK-AT ?auto_439 ?auto_448 ) ( OBJ-AT ?auto_437 ?auto_448 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_437 ?auto_439 ?auto_448 )
      ( DELIVER-PKG ?auto_437 ?auto_438 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13551 - OBJ
      ?auto_13552 - LOCATION
    )
    :vars
    (
      ?auto_13564 - LOCATION
      ?auto_13553 - AIRPLANE
      ?auto_13561 - LOCATION
      ?auto_13558 - LOCATION
      ?auto_13563 - CITY
      ?auto_13562 - LOCATION
      ?auto_13557 - CITY
      ?auto_13555 - LOCATION
      ?auto_13556 - CITY
      ?auto_13559 - TRUCK
      ?auto_13566 - LOCATION
      ?auto_13567 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_13564 ) ( AIRPORT ?auto_13552 ) ( AIRPLANE-AT ?auto_13553 ?auto_13564 ) ( not ( = ?auto_13564 ?auto_13552 ) ) ( AIRPLANE-AT ?auto_13553 ?auto_13561 ) ( IN-CITY ?auto_13558 ?auto_13563 ) ( IN-CITY ?auto_13561 ?auto_13563 ) ( not ( = ?auto_13561 ?auto_13558 ) ) ( OBJ-AT ?auto_13551 ?auto_13558 ) ( IN-CITY ?auto_13562 ?auto_13557 ) ( IN-CITY ?auto_13558 ?auto_13557 ) ( not ( = ?auto_13558 ?auto_13562 ) ) ( IN-CITY ?auto_13555 ?auto_13556 ) ( IN-CITY ?auto_13562 ?auto_13556 ) ( not ( = ?auto_13562 ?auto_13555 ) ) ( TRUCK-AT ?auto_13559 ?auto_13566 ) ( IN-CITY ?auto_13566 ?auto_13567 ) ( IN-CITY ?auto_13555 ?auto_13567 ) ( not ( = ?auto_13555 ?auto_13566 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_13559 ?auto_13566 ?auto_13555 ?auto_13567 )
      ( DELIVER-PKG ?auto_13551 ?auto_13552 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_6881 - OBJ
      ?auto_6882 - LOCATION
    )
    :vars
    (
      ?auto_6886 - LOCATION
      ?auto_6893 - LOCATION
      ?auto_6889 - LOCATION
      ?auto_6892 - CITY
      ?auto_6891 - TRUCK
      ?auto_6887 - LOCATION
      ?auto_6896 - CITY
      ?auto_6895 - LOCATION
      ?auto_6890 - LOCATION
      ?auto_6897 - LOCATION
      ?auto_6888 - LOCATION
      ?auto_6885 - LOCATION
      ?auto_6899 - LOCATION
      ?auto_6894 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_6886 ) ( AIRPORT ?auto_6882 ) ( not ( = ?auto_6886 ?auto_6882 ) ) ( AIRPORT ?auto_6893 ) ( not ( = ?auto_6893 ?auto_6886 ) ) ( IN-CITY ?auto_6889 ?auto_6892 ) ( IN-CITY ?auto_6886 ?auto_6892 ) ( not ( = ?auto_6886 ?auto_6889 ) ) ( OBJ-AT ?auto_6881 ?auto_6889 ) ( TRUCK-AT ?auto_6891 ?auto_6887 ) ( IN-CITY ?auto_6887 ?auto_6896 ) ( IN-CITY ?auto_6889 ?auto_6896 ) ( not ( = ?auto_6889 ?auto_6887 ) ) ( AIRPORT ?auto_6895 ) ( not ( = ?auto_6895 ?auto_6893 ) ) ( AIRPORT ?auto_6890 ) ( not ( = ?auto_6890 ?auto_6895 ) ) ( AIRPORT ?auto_6897 ) ( not ( = ?auto_6897 ?auto_6890 ) ) ( AIRPORT ?auto_6888 ) ( not ( = ?auto_6888 ?auto_6897 ) ) ( AIRPORT ?auto_6885 ) ( not ( = ?auto_6885 ?auto_6888 ) ) ( AIRPORT ?auto_6899 ) ( AIRPLANE-AT ?auto_6894 ?auto_6899 ) ( not ( = ?auto_6899 ?auto_6885 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_6894 ?auto_6899 ?auto_6885 )
      ( DELIVER-PKG ?auto_6881 ?auto_6882 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_6845 - OBJ
      ?auto_6846 - LOCATION
    )
    :vars
    (
      ?auto_6856 - LOCATION
      ?auto_6852 - LOCATION
      ?auto_6848 - LOCATION
      ?auto_6855 - CITY
      ?auto_6857 - TRUCK
      ?auto_6853 - LOCATION
      ?auto_6858 - CITY
      ?auto_6847 - LOCATION
      ?auto_6860 - LOCATION
      ?auto_6850 - LOCATION
      ?auto_6859 - LOCATION
      ?auto_6862 - LOCATION
      ?auto_6851 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_6856 ) ( AIRPORT ?auto_6846 ) ( not ( = ?auto_6856 ?auto_6846 ) ) ( AIRPORT ?auto_6852 ) ( not ( = ?auto_6852 ?auto_6856 ) ) ( IN-CITY ?auto_6848 ?auto_6855 ) ( IN-CITY ?auto_6856 ?auto_6855 ) ( not ( = ?auto_6856 ?auto_6848 ) ) ( OBJ-AT ?auto_6845 ?auto_6848 ) ( TRUCK-AT ?auto_6857 ?auto_6853 ) ( IN-CITY ?auto_6853 ?auto_6858 ) ( IN-CITY ?auto_6848 ?auto_6858 ) ( not ( = ?auto_6848 ?auto_6853 ) ) ( AIRPORT ?auto_6847 ) ( not ( = ?auto_6847 ?auto_6852 ) ) ( AIRPORT ?auto_6860 ) ( not ( = ?auto_6860 ?auto_6847 ) ) ( AIRPORT ?auto_6850 ) ( not ( = ?auto_6850 ?auto_6860 ) ) ( AIRPORT ?auto_6859 ) ( not ( = ?auto_6859 ?auto_6850 ) ) ( AIRPORT ?auto_6862 ) ( AIRPLANE-AT ?auto_6851 ?auto_6862 ) ( not ( = ?auto_6862 ?auto_6859 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_6851 ?auto_6862 ?auto_6859 )
      ( DELIVER-PKG ?auto_6845 ?auto_6846 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_11539 - OBJ
      ?auto_11540 - LOCATION
    )
    :vars
    (
      ?auto_11547 - LOCATION
      ?auto_11544 - CITY
      ?auto_11551 - LOCATION
      ?auto_11546 - CITY
      ?auto_11543 - LOCATION
      ?auto_11545 - CITY
      ?auto_11550 - LOCATION
      ?auto_11548 - CITY
      ?auto_11549 - TRUCK
      ?auto_11553 - LOCATION
      ?auto_11554 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_11547 ?auto_11544 ) ( IN-CITY ?auto_11540 ?auto_11544 ) ( not ( = ?auto_11540 ?auto_11547 ) ) ( OBJ-AT ?auto_11539 ?auto_11547 ) ( IN-CITY ?auto_11551 ?auto_11546 ) ( IN-CITY ?auto_11547 ?auto_11546 ) ( not ( = ?auto_11547 ?auto_11551 ) ) ( IN-CITY ?auto_11543 ?auto_11545 ) ( IN-CITY ?auto_11551 ?auto_11545 ) ( not ( = ?auto_11551 ?auto_11543 ) ) ( IN-CITY ?auto_11550 ?auto_11548 ) ( IN-CITY ?auto_11543 ?auto_11548 ) ( not ( = ?auto_11543 ?auto_11550 ) ) ( TRUCK-AT ?auto_11549 ?auto_11553 ) ( IN-CITY ?auto_11553 ?auto_11554 ) ( IN-CITY ?auto_11550 ?auto_11554 ) ( not ( = ?auto_11550 ?auto_11553 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_11549 ?auto_11553 ?auto_11550 ?auto_11554 )
      ( DELIVER-PKG ?auto_11539 ?auto_11540 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1074 - OBJ
      ?auto_1075 - LOCATION
    )
    :vars
    (
      ?auto_1081 - LOCATION
      ?auto_1076 - LOCATION
      ?auto_1086 - LOCATION
      ?auto_1078 - CITY
      ?auto_1077 - LOCATION
      ?auto_1082 - CITY
      ?auto_1083 - LOCATION
      ?auto_1079 - LOCATION
      ?auto_1085 - LOCATION
      ?auto_1080 - AIRPLANE
      ?auto_1084 - TRUCK
      ?auto_1090 - LOCATION
      ?auto_1091 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_1081 ) ( AIRPORT ?auto_1075 ) ( not ( = ?auto_1081 ?auto_1075 ) ) ( AIRPORT ?auto_1076 ) ( not ( = ?auto_1076 ?auto_1081 ) ) ( IN-CITY ?auto_1086 ?auto_1078 ) ( IN-CITY ?auto_1081 ?auto_1078 ) ( not ( = ?auto_1081 ?auto_1086 ) ) ( OBJ-AT ?auto_1074 ?auto_1086 ) ( IN-CITY ?auto_1077 ?auto_1082 ) ( IN-CITY ?auto_1086 ?auto_1082 ) ( not ( = ?auto_1086 ?auto_1077 ) ) ( AIRPORT ?auto_1083 ) ( not ( = ?auto_1083 ?auto_1076 ) ) ( AIRPORT ?auto_1079 ) ( not ( = ?auto_1079 ?auto_1083 ) ) ( AIRPORT ?auto_1085 ) ( AIRPLANE-AT ?auto_1080 ?auto_1085 ) ( not ( = ?auto_1085 ?auto_1079 ) ) ( TRUCK-AT ?auto_1084 ?auto_1090 ) ( IN-CITY ?auto_1090 ?auto_1091 ) ( IN-CITY ?auto_1077 ?auto_1091 ) ( not ( = ?auto_1077 ?auto_1090 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1084 ?auto_1090 ?auto_1077 ?auto_1091 )
      ( DELIVER-PKG ?auto_1074 ?auto_1075 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1110 - OBJ
      ?auto_1111 - LOCATION
    )
    :vars
    (
      ?auto_1126 - LOCATION
      ?auto_1116 - LOCATION
      ?auto_1115 - LOCATION
      ?auto_1119 - CITY
      ?auto_1122 - LOCATION
      ?auto_1125 - CITY
      ?auto_1124 - LOCATION
      ?auto_1114 - LOCATION
      ?auto_1123 - LOCATION
      ?auto_1113 - AIRPLANE
      ?auto_1117 - LOCATION
      ?auto_1112 - CITY
      ?auto_1118 - TRUCK
      ?auto_1128 - LOCATION
      ?auto_1129 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_1126 ) ( AIRPORT ?auto_1111 ) ( not ( = ?auto_1126 ?auto_1111 ) ) ( AIRPORT ?auto_1116 ) ( not ( = ?auto_1116 ?auto_1126 ) ) ( IN-CITY ?auto_1115 ?auto_1119 ) ( IN-CITY ?auto_1126 ?auto_1119 ) ( not ( = ?auto_1126 ?auto_1115 ) ) ( OBJ-AT ?auto_1110 ?auto_1115 ) ( IN-CITY ?auto_1122 ?auto_1125 ) ( IN-CITY ?auto_1115 ?auto_1125 ) ( not ( = ?auto_1115 ?auto_1122 ) ) ( AIRPORT ?auto_1124 ) ( not ( = ?auto_1124 ?auto_1116 ) ) ( AIRPORT ?auto_1114 ) ( not ( = ?auto_1114 ?auto_1124 ) ) ( AIRPORT ?auto_1123 ) ( AIRPLANE-AT ?auto_1113 ?auto_1123 ) ( not ( = ?auto_1123 ?auto_1114 ) ) ( IN-CITY ?auto_1117 ?auto_1112 ) ( IN-CITY ?auto_1122 ?auto_1112 ) ( not ( = ?auto_1122 ?auto_1117 ) ) ( TRUCK-AT ?auto_1118 ?auto_1128 ) ( IN-CITY ?auto_1128 ?auto_1129 ) ( IN-CITY ?auto_1117 ?auto_1129 ) ( not ( = ?auto_1117 ?auto_1128 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1118 ?auto_1128 ?auto_1117 ?auto_1129 )
      ( DELIVER-PKG ?auto_1110 ?auto_1111 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1169 - OBJ
      ?auto_1170 - LOCATION
    )
    :vars
    (
      ?auto_1171 - LOCATION
      ?auto_1176 - CITY
      ?auto_1172 - TRUCK
      ?auto_1174 - LOCATION
      ?auto_1173 - CITY
      ?auto_1179 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_1171 ?auto_1176 ) ( IN-CITY ?auto_1170 ?auto_1176 ) ( not ( = ?auto_1170 ?auto_1171 ) ) ( TRUCK-AT ?auto_1172 ?auto_1174 ) ( IN-CITY ?auto_1174 ?auto_1173 ) ( IN-CITY ?auto_1171 ?auto_1173 ) ( not ( = ?auto_1171 ?auto_1174 ) ) ( IN-AIRPLANE ?auto_1169 ?auto_1179 ) ( AIRPLANE-AT ?auto_1179 ?auto_1171 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_1169 ?auto_1171 )
      ( DELIVER-PKG ?auto_1169 ?auto_1170 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1181 - OBJ
      ?auto_1182 - LOCATION
    )
    :vars
    (
      ?auto_1188 - LOCATION
      ?auto_1187 - CITY
      ?auto_1190 - TRUCK
      ?auto_1189 - LOCATION
      ?auto_1186 - CITY
      ?auto_1184 - AIRPLANE
      ?auto_1192 - LOCATION
    )
    :precondition
    ( and ( IN-CITY ?auto_1188 ?auto_1187 ) ( IN-CITY ?auto_1182 ?auto_1187 ) ( not ( = ?auto_1182 ?auto_1188 ) ) ( TRUCK-AT ?auto_1190 ?auto_1189 ) ( IN-CITY ?auto_1189 ?auto_1186 ) ( IN-CITY ?auto_1188 ?auto_1186 ) ( not ( = ?auto_1188 ?auto_1189 ) ) ( IN-AIRPLANE ?auto_1181 ?auto_1184 ) ( AIRPORT ?auto_1192 ) ( AIRPORT ?auto_1188 ) ( AIRPLANE-AT ?auto_1184 ?auto_1192 ) ( not ( = ?auto_1192 ?auto_1188 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_1184 ?auto_1192 ?auto_1188 )
      ( DELIVER-PKG ?auto_1181 ?auto_1182 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1194 - OBJ
      ?auto_1195 - LOCATION
    )
    :vars
    (
      ?auto_1196 - LOCATION
      ?auto_1197 - CITY
      ?auto_1198 - TRUCK
      ?auto_1201 - LOCATION
      ?auto_1204 - CITY
      ?auto_1200 - LOCATION
      ?auto_1203 - AIRPLANE
      ?auto_1205 - LOCATION
    )
    :precondition
    ( and ( IN-CITY ?auto_1196 ?auto_1197 ) ( IN-CITY ?auto_1195 ?auto_1197 ) ( not ( = ?auto_1195 ?auto_1196 ) ) ( TRUCK-AT ?auto_1198 ?auto_1201 ) ( IN-CITY ?auto_1201 ?auto_1204 ) ( IN-CITY ?auto_1196 ?auto_1204 ) ( not ( = ?auto_1196 ?auto_1201 ) ) ( AIRPORT ?auto_1200 ) ( AIRPORT ?auto_1196 ) ( AIRPLANE-AT ?auto_1203 ?auto_1200 ) ( not ( = ?auto_1200 ?auto_1196 ) ) ( OBJ-AT ?auto_1194 ?auto_1205 ) ( AIRPLANE-AT ?auto_1203 ?auto_1205 ) )
    :subtasks
    ( ( !LOAD-AIRPLANE ?auto_1194 ?auto_1203 ?auto_1205 )
      ( DELIVER-PKG ?auto_1194 ?auto_1195 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_5286 - OBJ
      ?auto_5287 - LOCATION
    )
    :vars
    (
      ?auto_5298 - LOCATION
      ?auto_5288 - CITY
      ?auto_5295 - TRUCK
      ?auto_5300 - LOCATION
      ?auto_5297 - CITY
      ?auto_5291 - LOCATION
      ?auto_5292 - LOCATION
      ?auto_5296 - LOCATION
      ?auto_5301 - LOCATION
      ?auto_5289 - LOCATION
      ?auto_5290 - LOCATION
      ?auto_5294 - LOCATION
      ?auto_5304 - LOCATION
      ?auto_5293 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_5298 ?auto_5288 ) ( IN-CITY ?auto_5287 ?auto_5288 ) ( not ( = ?auto_5287 ?auto_5298 ) ) ( TRUCK-AT ?auto_5295 ?auto_5300 ) ( IN-CITY ?auto_5300 ?auto_5297 ) ( IN-CITY ?auto_5298 ?auto_5297 ) ( not ( = ?auto_5298 ?auto_5300 ) ) ( AIRPORT ?auto_5291 ) ( AIRPORT ?auto_5298 ) ( not ( = ?auto_5291 ?auto_5298 ) ) ( OBJ-AT ?auto_5286 ?auto_5291 ) ( AIRPORT ?auto_5292 ) ( not ( = ?auto_5292 ?auto_5291 ) ) ( AIRPORT ?auto_5296 ) ( not ( = ?auto_5296 ?auto_5292 ) ) ( AIRPORT ?auto_5301 ) ( not ( = ?auto_5301 ?auto_5296 ) ) ( AIRPORT ?auto_5289 ) ( not ( = ?auto_5289 ?auto_5301 ) ) ( AIRPORT ?auto_5290 ) ( not ( = ?auto_5290 ?auto_5289 ) ) ( AIRPORT ?auto_5294 ) ( not ( = ?auto_5294 ?auto_5290 ) ) ( AIRPORT ?auto_5304 ) ( AIRPLANE-AT ?auto_5293 ?auto_5304 ) ( not ( = ?auto_5304 ?auto_5294 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_5293 ?auto_5304 ?auto_5294 )
      ( DELIVER-PKG ?auto_5286 ?auto_5287 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1223 - OBJ
      ?auto_1224 - LOCATION
    )
    :vars
    (
      ?auto_1233 - LOCATION
      ?auto_1231 - CITY
      ?auto_1232 - TRUCK
      ?auto_1226 - LOCATION
      ?auto_1234 - CITY
      ?auto_1228 - LOCATION
      ?auto_1225 - LOCATION
      ?auto_1227 - AIRPLANE
      ?auto_1236 - TRUCK
    )
    :precondition
    ( and ( IN-CITY ?auto_1233 ?auto_1231 ) ( IN-CITY ?auto_1224 ?auto_1231 ) ( not ( = ?auto_1224 ?auto_1233 ) ) ( TRUCK-AT ?auto_1232 ?auto_1226 ) ( IN-CITY ?auto_1226 ?auto_1234 ) ( IN-CITY ?auto_1233 ?auto_1234 ) ( not ( = ?auto_1233 ?auto_1226 ) ) ( AIRPORT ?auto_1228 ) ( AIRPORT ?auto_1233 ) ( not ( = ?auto_1228 ?auto_1233 ) ) ( AIRPORT ?auto_1225 ) ( AIRPLANE-AT ?auto_1227 ?auto_1225 ) ( not ( = ?auto_1225 ?auto_1228 ) ) ( TRUCK-AT ?auto_1236 ?auto_1228 ) ( IN-TRUCK ?auto_1223 ?auto_1236 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_1223 ?auto_1228 )
      ( DELIVER-PKG ?auto_1223 ?auto_1224 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1238 - OBJ
      ?auto_1239 - LOCATION
    )
    :vars
    (
      ?auto_1245 - LOCATION
      ?auto_1246 - CITY
      ?auto_1244 - TRUCK
      ?auto_1240 - LOCATION
      ?auto_1241 - CITY
      ?auto_1242 - LOCATION
      ?auto_1249 - LOCATION
      ?auto_1250 - AIRPLANE
      ?auto_1247 - TRUCK
      ?auto_1252 - LOCATION
      ?auto_1253 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_1245 ?auto_1246 ) ( IN-CITY ?auto_1239 ?auto_1246 ) ( not ( = ?auto_1239 ?auto_1245 ) ) ( TRUCK-AT ?auto_1244 ?auto_1240 ) ( IN-CITY ?auto_1240 ?auto_1241 ) ( IN-CITY ?auto_1245 ?auto_1241 ) ( not ( = ?auto_1245 ?auto_1240 ) ) ( AIRPORT ?auto_1242 ) ( AIRPORT ?auto_1245 ) ( not ( = ?auto_1242 ?auto_1245 ) ) ( AIRPORT ?auto_1249 ) ( AIRPLANE-AT ?auto_1250 ?auto_1249 ) ( not ( = ?auto_1249 ?auto_1242 ) ) ( IN-TRUCK ?auto_1238 ?auto_1247 ) ( TRUCK-AT ?auto_1247 ?auto_1252 ) ( IN-CITY ?auto_1252 ?auto_1253 ) ( IN-CITY ?auto_1242 ?auto_1253 ) ( not ( = ?auto_1242 ?auto_1252 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1247 ?auto_1252 ?auto_1242 ?auto_1253 )
      ( DELIVER-PKG ?auto_1238 ?auto_1239 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1255 - OBJ
      ?auto_1256 - LOCATION
    )
    :vars
    (
      ?auto_1264 - LOCATION
      ?auto_1257 - CITY
      ?auto_1261 - TRUCK
      ?auto_1258 - LOCATION
      ?auto_1259 - CITY
      ?auto_1260 - LOCATION
      ?auto_1266 - LOCATION
      ?auto_1267 - AIRPLANE
      ?auto_1265 - TRUCK
      ?auto_1268 - LOCATION
      ?auto_1269 - CITY
      ?auto_1271 - LOCATION
    )
    :precondition
    ( and ( IN-CITY ?auto_1264 ?auto_1257 ) ( IN-CITY ?auto_1256 ?auto_1257 ) ( not ( = ?auto_1256 ?auto_1264 ) ) ( TRUCK-AT ?auto_1261 ?auto_1258 ) ( IN-CITY ?auto_1258 ?auto_1259 ) ( IN-CITY ?auto_1264 ?auto_1259 ) ( not ( = ?auto_1264 ?auto_1258 ) ) ( AIRPORT ?auto_1260 ) ( AIRPORT ?auto_1264 ) ( not ( = ?auto_1260 ?auto_1264 ) ) ( AIRPORT ?auto_1266 ) ( AIRPLANE-AT ?auto_1267 ?auto_1266 ) ( not ( = ?auto_1266 ?auto_1260 ) ) ( TRUCK-AT ?auto_1265 ?auto_1268 ) ( IN-CITY ?auto_1268 ?auto_1269 ) ( IN-CITY ?auto_1260 ?auto_1269 ) ( not ( = ?auto_1260 ?auto_1268 ) ) ( TRUCK-AT ?auto_1265 ?auto_1271 ) ( OBJ-AT ?auto_1255 ?auto_1271 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_1255 ?auto_1265 ?auto_1271 )
      ( DELIVER-PKG ?auto_1255 ?auto_1256 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1273 - OBJ
      ?auto_1274 - LOCATION
    )
    :vars
    (
      ?auto_1275 - LOCATION
      ?auto_1284 - CITY
      ?auto_1281 - TRUCK
      ?auto_1285 - LOCATION
      ?auto_1286 - CITY
      ?auto_1282 - LOCATION
      ?auto_1277 - LOCATION
      ?auto_1276 - AIRPLANE
      ?auto_1283 - LOCATION
      ?auto_1279 - CITY
      ?auto_1280 - TRUCK
      ?auto_1290 - LOCATION
      ?auto_1291 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_1275 ?auto_1284 ) ( IN-CITY ?auto_1274 ?auto_1284 ) ( not ( = ?auto_1274 ?auto_1275 ) ) ( TRUCK-AT ?auto_1281 ?auto_1285 ) ( IN-CITY ?auto_1285 ?auto_1286 ) ( IN-CITY ?auto_1275 ?auto_1286 ) ( not ( = ?auto_1275 ?auto_1285 ) ) ( AIRPORT ?auto_1282 ) ( AIRPORT ?auto_1275 ) ( not ( = ?auto_1282 ?auto_1275 ) ) ( AIRPORT ?auto_1277 ) ( AIRPLANE-AT ?auto_1276 ?auto_1277 ) ( not ( = ?auto_1277 ?auto_1282 ) ) ( IN-CITY ?auto_1283 ?auto_1279 ) ( IN-CITY ?auto_1282 ?auto_1279 ) ( not ( = ?auto_1282 ?auto_1283 ) ) ( OBJ-AT ?auto_1273 ?auto_1283 ) ( TRUCK-AT ?auto_1280 ?auto_1290 ) ( IN-CITY ?auto_1290 ?auto_1291 ) ( IN-CITY ?auto_1283 ?auto_1291 ) ( not ( = ?auto_1283 ?auto_1290 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1280 ?auto_1290 ?auto_1283 ?auto_1291 )
      ( DELIVER-PKG ?auto_1273 ?auto_1274 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1514 - OBJ
      ?auto_1515 - LOCATION
    )
    :vars
    (
      ?auto_1528 - LOCATION
      ?auto_1523 - CITY
      ?auto_1530 - TRUCK
      ?auto_1524 - LOCATION
      ?auto_1525 - CITY
      ?auto_1531 - LOCATION
      ?auto_1521 - LOCATION
      ?auto_1519 - LOCATION
      ?auto_1526 - CITY
      ?auto_1520 - TRUCK
      ?auto_1522 - LOCATION
      ?auto_1518 - CITY
      ?auto_1516 - LOCATION
      ?auto_1532 - LOCATION
      ?auto_1534 - LOCATION
      ?auto_1517 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_1528 ?auto_1523 ) ( IN-CITY ?auto_1515 ?auto_1523 ) ( not ( = ?auto_1515 ?auto_1528 ) ) ( TRUCK-AT ?auto_1530 ?auto_1524 ) ( IN-CITY ?auto_1524 ?auto_1525 ) ( IN-CITY ?auto_1528 ?auto_1525 ) ( not ( = ?auto_1528 ?auto_1524 ) ) ( AIRPORT ?auto_1531 ) ( AIRPORT ?auto_1528 ) ( not ( = ?auto_1531 ?auto_1528 ) ) ( AIRPORT ?auto_1521 ) ( not ( = ?auto_1521 ?auto_1531 ) ) ( IN-CITY ?auto_1519 ?auto_1526 ) ( IN-CITY ?auto_1531 ?auto_1526 ) ( not ( = ?auto_1531 ?auto_1519 ) ) ( OBJ-AT ?auto_1514 ?auto_1519 ) ( TRUCK-AT ?auto_1520 ?auto_1522 ) ( IN-CITY ?auto_1522 ?auto_1518 ) ( IN-CITY ?auto_1519 ?auto_1518 ) ( not ( = ?auto_1519 ?auto_1522 ) ) ( AIRPORT ?auto_1516 ) ( not ( = ?auto_1516 ?auto_1521 ) ) ( AIRPORT ?auto_1532 ) ( not ( = ?auto_1532 ?auto_1516 ) ) ( AIRPORT ?auto_1534 ) ( AIRPLANE-AT ?auto_1517 ?auto_1534 ) ( not ( = ?auto_1534 ?auto_1532 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_1517 ?auto_1534 ?auto_1532 )
      ( DELIVER-PKG ?auto_1514 ?auto_1515 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1474 - OBJ
      ?auto_1475 - LOCATION
    )
    :vars
    (
      ?auto_1479 - LOCATION
      ?auto_1482 - CITY
      ?auto_1483 - TRUCK
      ?auto_1486 - LOCATION
      ?auto_1480 - CITY
      ?auto_1481 - LOCATION
      ?auto_1476 - LOCATION
      ?auto_1477 - LOCATION
      ?auto_1478 - CITY
      ?auto_1488 - TRUCK
      ?auto_1487 - LOCATION
      ?auto_1485 - CITY
      ?auto_1491 - LOCATION
      ?auto_1493 - LOCATION
      ?auto_1489 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_1479 ?auto_1482 ) ( IN-CITY ?auto_1475 ?auto_1482 ) ( not ( = ?auto_1475 ?auto_1479 ) ) ( TRUCK-AT ?auto_1483 ?auto_1486 ) ( IN-CITY ?auto_1486 ?auto_1480 ) ( IN-CITY ?auto_1479 ?auto_1480 ) ( not ( = ?auto_1479 ?auto_1486 ) ) ( AIRPORT ?auto_1481 ) ( AIRPORT ?auto_1479 ) ( not ( = ?auto_1481 ?auto_1479 ) ) ( AIRPORT ?auto_1476 ) ( not ( = ?auto_1476 ?auto_1481 ) ) ( IN-CITY ?auto_1477 ?auto_1478 ) ( IN-CITY ?auto_1481 ?auto_1478 ) ( not ( = ?auto_1481 ?auto_1477 ) ) ( OBJ-AT ?auto_1474 ?auto_1477 ) ( TRUCK-AT ?auto_1488 ?auto_1487 ) ( IN-CITY ?auto_1487 ?auto_1485 ) ( IN-CITY ?auto_1477 ?auto_1485 ) ( not ( = ?auto_1477 ?auto_1487 ) ) ( AIRPORT ?auto_1491 ) ( not ( = ?auto_1491 ?auto_1476 ) ) ( AIRPORT ?auto_1493 ) ( AIRPLANE-AT ?auto_1489 ?auto_1493 ) ( not ( = ?auto_1493 ?auto_1491 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_1489 ?auto_1493 ?auto_1491 )
      ( DELIVER-PKG ?auto_1474 ?auto_1475 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1556 - OBJ
      ?auto_1557 - LOCATION
    )
    :vars
    (
      ?auto_1565 - LOCATION
      ?auto_1560 - CITY
      ?auto_1569 - TRUCK
      ?auto_1562 - LOCATION
      ?auto_1564 - CITY
      ?auto_1568 - LOCATION
      ?auto_1558 - LOCATION
      ?auto_1574 - LOCATION
      ?auto_1575 - CITY
      ?auto_1563 - LOCATION
      ?auto_1572 - CITY
      ?auto_1567 - LOCATION
      ?auto_1566 - LOCATION
      ?auto_1559 - LOCATION
      ?auto_1561 - AIRPLANE
      ?auto_1570 - TRUCK
      ?auto_1577 - LOCATION
      ?auto_1578 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_1565 ?auto_1560 ) ( IN-CITY ?auto_1557 ?auto_1560 ) ( not ( = ?auto_1557 ?auto_1565 ) ) ( TRUCK-AT ?auto_1569 ?auto_1562 ) ( IN-CITY ?auto_1562 ?auto_1564 ) ( IN-CITY ?auto_1565 ?auto_1564 ) ( not ( = ?auto_1565 ?auto_1562 ) ) ( AIRPORT ?auto_1568 ) ( AIRPORT ?auto_1565 ) ( not ( = ?auto_1568 ?auto_1565 ) ) ( AIRPORT ?auto_1558 ) ( not ( = ?auto_1558 ?auto_1568 ) ) ( IN-CITY ?auto_1574 ?auto_1575 ) ( IN-CITY ?auto_1568 ?auto_1575 ) ( not ( = ?auto_1568 ?auto_1574 ) ) ( OBJ-AT ?auto_1556 ?auto_1574 ) ( IN-CITY ?auto_1563 ?auto_1572 ) ( IN-CITY ?auto_1574 ?auto_1572 ) ( not ( = ?auto_1574 ?auto_1563 ) ) ( AIRPORT ?auto_1567 ) ( not ( = ?auto_1567 ?auto_1558 ) ) ( AIRPORT ?auto_1566 ) ( not ( = ?auto_1566 ?auto_1567 ) ) ( AIRPORT ?auto_1559 ) ( AIRPLANE-AT ?auto_1561 ?auto_1559 ) ( not ( = ?auto_1559 ?auto_1566 ) ) ( TRUCK-AT ?auto_1570 ?auto_1577 ) ( IN-CITY ?auto_1577 ?auto_1578 ) ( IN-CITY ?auto_1563 ?auto_1578 ) ( not ( = ?auto_1563 ?auto_1577 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1570 ?auto_1577 ?auto_1563 ?auto_1578 )
      ( DELIVER-PKG ?auto_1556 ?auto_1557 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1602 - OBJ
      ?auto_1603 - LOCATION
    )
    :vars
    (
      ?auto_1613 - LOCATION
      ?auto_1618 - CITY
      ?auto_1609 - TRUCK
      ?auto_1621 - LOCATION
      ?auto_1620 - CITY
      ?auto_1605 - LOCATION
      ?auto_1608 - LOCATION
      ?auto_1617 - LOCATION
      ?auto_1619 - CITY
      ?auto_1607 - LOCATION
      ?auto_1616 - CITY
      ?auto_1615 - LOCATION
      ?auto_1614 - LOCATION
      ?auto_1611 - LOCATION
      ?auto_1606 - AIRPLANE
      ?auto_1623 - LOCATION
      ?auto_1622 - CITY
      ?auto_1604 - TRUCK
      ?auto_1625 - LOCATION
      ?auto_1626 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_1613 ?auto_1618 ) ( IN-CITY ?auto_1603 ?auto_1618 ) ( not ( = ?auto_1603 ?auto_1613 ) ) ( TRUCK-AT ?auto_1609 ?auto_1621 ) ( IN-CITY ?auto_1621 ?auto_1620 ) ( IN-CITY ?auto_1613 ?auto_1620 ) ( not ( = ?auto_1613 ?auto_1621 ) ) ( AIRPORT ?auto_1605 ) ( AIRPORT ?auto_1613 ) ( not ( = ?auto_1605 ?auto_1613 ) ) ( AIRPORT ?auto_1608 ) ( not ( = ?auto_1608 ?auto_1605 ) ) ( IN-CITY ?auto_1617 ?auto_1619 ) ( IN-CITY ?auto_1605 ?auto_1619 ) ( not ( = ?auto_1605 ?auto_1617 ) ) ( OBJ-AT ?auto_1602 ?auto_1617 ) ( IN-CITY ?auto_1607 ?auto_1616 ) ( IN-CITY ?auto_1617 ?auto_1616 ) ( not ( = ?auto_1617 ?auto_1607 ) ) ( AIRPORT ?auto_1615 ) ( not ( = ?auto_1615 ?auto_1608 ) ) ( AIRPORT ?auto_1614 ) ( not ( = ?auto_1614 ?auto_1615 ) ) ( AIRPORT ?auto_1611 ) ( AIRPLANE-AT ?auto_1606 ?auto_1611 ) ( not ( = ?auto_1611 ?auto_1614 ) ) ( IN-CITY ?auto_1623 ?auto_1622 ) ( IN-CITY ?auto_1607 ?auto_1622 ) ( not ( = ?auto_1607 ?auto_1623 ) ) ( TRUCK-AT ?auto_1604 ?auto_1625 ) ( IN-CITY ?auto_1625 ?auto_1626 ) ( IN-CITY ?auto_1623 ?auto_1626 ) ( not ( = ?auto_1623 ?auto_1625 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_1604 ?auto_1625 ?auto_1623 ?auto_1626 )
      ( DELIVER-PKG ?auto_1602 ?auto_1603 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_1887 - OBJ
      ?auto_1888 - LOCATION
    )
    :vars
    (
      ?auto_1891 - LOCATION
      ?auto_1889 - LOCATION
      ?auto_1895 - LOCATION
      ?auto_1892 - LOCATION
      ?auto_1896 - LOCATION
      ?auto_1897 - LOCATION
      ?auto_1899 - LOCATION
      ?auto_1893 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_1891 ) ( AIRPORT ?auto_1888 ) ( not ( = ?auto_1891 ?auto_1888 ) ) ( OBJ-AT ?auto_1887 ?auto_1891 ) ( AIRPORT ?auto_1889 ) ( not ( = ?auto_1889 ?auto_1891 ) ) ( AIRPORT ?auto_1895 ) ( not ( = ?auto_1895 ?auto_1889 ) ) ( AIRPORT ?auto_1892 ) ( not ( = ?auto_1892 ?auto_1895 ) ) ( AIRPORT ?auto_1896 ) ( not ( = ?auto_1896 ?auto_1892 ) ) ( AIRPORT ?auto_1897 ) ( not ( = ?auto_1897 ?auto_1896 ) ) ( AIRPORT ?auto_1899 ) ( AIRPLANE-AT ?auto_1893 ?auto_1899 ) ( not ( = ?auto_1899 ?auto_1897 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_1893 ?auto_1899 ?auto_1897 )
      ( DELIVER-PKG ?auto_1887 ?auto_1888 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_10371 - OBJ
      ?auto_10372 - LOCATION
    )
    :vars
    (
      ?auto_10381 - TRUCK
      ?auto_10385 - LOCATION
      ?auto_10376 - CITY
      ?auto_10379 - LOCATION
      ?auto_10384 - LOCATION
      ?auto_10380 - LOCATION
      ?auto_10375 - LOCATION
      ?auto_10378 - LOCATION
      ?auto_10382 - LOCATION
      ?auto_10377 - LOCATION
      ?auto_10387 - LOCATION
      ?auto_10374 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_10381 ?auto_10385 ) ( IN-CITY ?auto_10385 ?auto_10376 ) ( IN-CITY ?auto_10372 ?auto_10376 ) ( not ( = ?auto_10372 ?auto_10385 ) ) ( TRUCK-AT ?auto_10381 ?auto_10379 ) ( AIRPORT ?auto_10384 ) ( AIRPORT ?auto_10379 ) ( not ( = ?auto_10384 ?auto_10379 ) ) ( OBJ-AT ?auto_10371 ?auto_10384 ) ( AIRPORT ?auto_10380 ) ( not ( = ?auto_10380 ?auto_10384 ) ) ( AIRPORT ?auto_10375 ) ( not ( = ?auto_10375 ?auto_10380 ) ) ( AIRPORT ?auto_10378 ) ( not ( = ?auto_10378 ?auto_10375 ) ) ( AIRPORT ?auto_10382 ) ( not ( = ?auto_10382 ?auto_10378 ) ) ( AIRPORT ?auto_10377 ) ( not ( = ?auto_10377 ?auto_10382 ) ) ( AIRPORT ?auto_10387 ) ( AIRPLANE-AT ?auto_10374 ?auto_10387 ) ( not ( = ?auto_10387 ?auto_10377 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_10374 ?auto_10387 ?auto_10377 )
      ( DELIVER-PKG ?auto_10371 ?auto_10372 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_2945 - OBJ
      ?auto_2946 - LOCATION
    )
    :vars
    (
      ?auto_2955 - TRUCK
      ?auto_2950 - LOCATION
      ?auto_2962 - CITY
      ?auto_2953 - LOCATION
      ?auto_2951 - LOCATION
      ?auto_2958 - LOCATION
      ?auto_2954 - LOCATION
      ?auto_2961 - CITY
      ?auto_2956 - TRUCK
      ?auto_2948 - LOCATION
      ?auto_2947 - CITY
      ?auto_2952 - LOCATION
      ?auto_2959 - LOCATION
      ?auto_2964 - LOCATION
      ?auto_2949 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_2955 ?auto_2950 ) ( IN-CITY ?auto_2950 ?auto_2962 ) ( IN-CITY ?auto_2946 ?auto_2962 ) ( not ( = ?auto_2946 ?auto_2950 ) ) ( TRUCK-AT ?auto_2955 ?auto_2953 ) ( AIRPORT ?auto_2951 ) ( AIRPORT ?auto_2953 ) ( not ( = ?auto_2951 ?auto_2953 ) ) ( AIRPORT ?auto_2958 ) ( not ( = ?auto_2958 ?auto_2951 ) ) ( IN-CITY ?auto_2954 ?auto_2961 ) ( IN-CITY ?auto_2951 ?auto_2961 ) ( not ( = ?auto_2951 ?auto_2954 ) ) ( OBJ-AT ?auto_2945 ?auto_2954 ) ( TRUCK-AT ?auto_2956 ?auto_2948 ) ( IN-CITY ?auto_2948 ?auto_2947 ) ( IN-CITY ?auto_2954 ?auto_2947 ) ( not ( = ?auto_2954 ?auto_2948 ) ) ( AIRPORT ?auto_2952 ) ( not ( = ?auto_2952 ?auto_2958 ) ) ( AIRPORT ?auto_2959 ) ( not ( = ?auto_2959 ?auto_2952 ) ) ( AIRPORT ?auto_2964 ) ( AIRPLANE-AT ?auto_2949 ?auto_2964 ) ( not ( = ?auto_2964 ?auto_2959 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_2949 ?auto_2964 ?auto_2959 )
      ( DELIVER-PKG ?auto_2945 ?auto_2946 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_2985 - OBJ
      ?auto_2986 - LOCATION
    )
    :vars
    (
      ?auto_2996 - TRUCK
      ?auto_2989 - LOCATION
      ?auto_2987 - CITY
      ?auto_2988 - LOCATION
      ?auto_3001 - LOCATION
      ?auto_2992 - LOCATION
      ?auto_2990 - LOCATION
      ?auto_2994 - CITY
      ?auto_2995 - TRUCK
      ?auto_3000 - LOCATION
      ?auto_2998 - CITY
      ?auto_2991 - LOCATION
      ?auto_2993 - LOCATION
      ?auto_3003 - LOCATION
      ?auto_3005 - LOCATION
      ?auto_2999 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_2996 ?auto_2989 ) ( IN-CITY ?auto_2989 ?auto_2987 ) ( IN-CITY ?auto_2986 ?auto_2987 ) ( not ( = ?auto_2986 ?auto_2989 ) ) ( TRUCK-AT ?auto_2996 ?auto_2988 ) ( AIRPORT ?auto_3001 ) ( AIRPORT ?auto_2988 ) ( not ( = ?auto_3001 ?auto_2988 ) ) ( AIRPORT ?auto_2992 ) ( not ( = ?auto_2992 ?auto_3001 ) ) ( IN-CITY ?auto_2990 ?auto_2994 ) ( IN-CITY ?auto_3001 ?auto_2994 ) ( not ( = ?auto_3001 ?auto_2990 ) ) ( OBJ-AT ?auto_2985 ?auto_2990 ) ( TRUCK-AT ?auto_2995 ?auto_3000 ) ( IN-CITY ?auto_3000 ?auto_2998 ) ( IN-CITY ?auto_2990 ?auto_2998 ) ( not ( = ?auto_2990 ?auto_3000 ) ) ( AIRPORT ?auto_2991 ) ( not ( = ?auto_2991 ?auto_2992 ) ) ( AIRPORT ?auto_2993 ) ( not ( = ?auto_2993 ?auto_2991 ) ) ( AIRPORT ?auto_3003 ) ( not ( = ?auto_3003 ?auto_2993 ) ) ( AIRPORT ?auto_3005 ) ( AIRPLANE-AT ?auto_2999 ?auto_3005 ) ( not ( = ?auto_3005 ?auto_3003 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_2999 ?auto_3005 ?auto_3003 )
      ( DELIVER-PKG ?auto_2985 ?auto_2986 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_5250 - OBJ
      ?auto_5251 - LOCATION
    )
    :vars
    (
      ?auto_5255 - LOCATION
      ?auto_5261 - CITY
      ?auto_5256 - TRUCK
      ?auto_5257 - LOCATION
      ?auto_5260 - CITY
      ?auto_5262 - LOCATION
      ?auto_5263 - LOCATION
      ?auto_5254 - LOCATION
      ?auto_5265 - LOCATION
      ?auto_5264 - LOCATION
      ?auto_5258 - LOCATION
      ?auto_5267 - LOCATION
      ?auto_5252 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_5255 ?auto_5261 ) ( IN-CITY ?auto_5251 ?auto_5261 ) ( not ( = ?auto_5251 ?auto_5255 ) ) ( TRUCK-AT ?auto_5256 ?auto_5257 ) ( IN-CITY ?auto_5257 ?auto_5260 ) ( IN-CITY ?auto_5255 ?auto_5260 ) ( not ( = ?auto_5255 ?auto_5257 ) ) ( AIRPORT ?auto_5262 ) ( AIRPORT ?auto_5255 ) ( not ( = ?auto_5262 ?auto_5255 ) ) ( OBJ-AT ?auto_5250 ?auto_5262 ) ( AIRPORT ?auto_5263 ) ( not ( = ?auto_5263 ?auto_5262 ) ) ( AIRPORT ?auto_5254 ) ( not ( = ?auto_5254 ?auto_5263 ) ) ( AIRPORT ?auto_5265 ) ( not ( = ?auto_5265 ?auto_5254 ) ) ( AIRPORT ?auto_5264 ) ( not ( = ?auto_5264 ?auto_5265 ) ) ( AIRPORT ?auto_5258 ) ( not ( = ?auto_5258 ?auto_5264 ) ) ( AIRPORT ?auto_5267 ) ( AIRPLANE-AT ?auto_5252 ?auto_5267 ) ( not ( = ?auto_5267 ?auto_5258 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_5252 ?auto_5267 ?auto_5258 )
      ( DELIVER-PKG ?auto_5250 ?auto_5251 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_4403 - OBJ
      ?auto_4404 - LOCATION
    )
    :vars
    (
      ?auto_4407 - LOCATION
      ?auto_4416 - LOCATION
      ?auto_4410 - LOCATION
      ?auto_4412 - CITY
      ?auto_4414 - LOCATION
      ?auto_4406 - CITY
      ?auto_4411 - LOCATION
      ?auto_4415 - LOCATION
      ?auto_4405 - AIRPLANE
      ?auto_4409 - TRUCK
      ?auto_4418 - LOCATION
      ?auto_4419 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_4407 ) ( AIRPORT ?auto_4404 ) ( not ( = ?auto_4407 ?auto_4404 ) ) ( AIRPORT ?auto_4416 ) ( not ( = ?auto_4416 ?auto_4407 ) ) ( IN-CITY ?auto_4410 ?auto_4412 ) ( IN-CITY ?auto_4407 ?auto_4412 ) ( not ( = ?auto_4407 ?auto_4410 ) ) ( OBJ-AT ?auto_4403 ?auto_4410 ) ( IN-CITY ?auto_4414 ?auto_4406 ) ( IN-CITY ?auto_4410 ?auto_4406 ) ( not ( = ?auto_4410 ?auto_4414 ) ) ( AIRPORT ?auto_4411 ) ( not ( = ?auto_4411 ?auto_4416 ) ) ( AIRPORT ?auto_4415 ) ( AIRPLANE-AT ?auto_4405 ?auto_4415 ) ( not ( = ?auto_4415 ?auto_4411 ) ) ( TRUCK-AT ?auto_4409 ?auto_4418 ) ( IN-CITY ?auto_4418 ?auto_4419 ) ( IN-CITY ?auto_4414 ?auto_4419 ) ( not ( = ?auto_4414 ?auto_4418 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_4409 ?auto_4418 ?auto_4414 ?auto_4419 )
      ( DELIVER-PKG ?auto_4403 ?auto_4404 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_8975 - OBJ
      ?auto_8976 - LOCATION
    )
    :vars
    (
      ?auto_8978 - LOCATION
      ?auto_8983 - LOCATION
      ?auto_8979 - TRUCK
      ?auto_8982 - LOCATION
      ?auto_8987 - CITY
      ?auto_8985 - LOCATION
      ?auto_8981 - LOCATION
      ?auto_8980 - LOCATION
      ?auto_8989 - LOCATION
      ?auto_8977 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_8978 ) ( AIRPORT ?auto_8976 ) ( not ( = ?auto_8978 ?auto_8976 ) ) ( AIRPORT ?auto_8983 ) ( not ( = ?auto_8983 ?auto_8978 ) ) ( TRUCK-AT ?auto_8979 ?auto_8982 ) ( IN-CITY ?auto_8982 ?auto_8987 ) ( IN-CITY ?auto_8978 ?auto_8987 ) ( not ( = ?auto_8978 ?auto_8982 ) ) ( TRUCK-AT ?auto_8979 ?auto_8985 ) ( OBJ-AT ?auto_8975 ?auto_8985 ) ( AIRPORT ?auto_8981 ) ( not ( = ?auto_8981 ?auto_8983 ) ) ( AIRPORT ?auto_8980 ) ( not ( = ?auto_8980 ?auto_8981 ) ) ( AIRPORT ?auto_8989 ) ( AIRPLANE-AT ?auto_8977 ?auto_8989 ) ( not ( = ?auto_8989 ?auto_8980 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_8977 ?auto_8989 ?auto_8980 )
      ( DELIVER-PKG ?auto_8975 ?auto_8976 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_12025 - OBJ
      ?auto_12026 - LOCATION
    )
    :vars
    (
      ?auto_12031 - LOCATION
      ?auto_12030 - LOCATION
      ?auto_12038 - TRUCK
      ?auto_12029 - LOCATION
      ?auto_12036 - CITY
      ?auto_12032 - LOCATION
      ?auto_12034 - LOCATION
      ?auto_12027 - LOCATION
      ?auto_12035 - LOCATION
      ?auto_12040 - LOCATION
      ?auto_12028 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_12031 ) ( AIRPORT ?auto_12026 ) ( not ( = ?auto_12031 ?auto_12026 ) ) ( AIRPORT ?auto_12030 ) ( not ( = ?auto_12030 ?auto_12031 ) ) ( TRUCK-AT ?auto_12038 ?auto_12029 ) ( IN-CITY ?auto_12029 ?auto_12036 ) ( IN-CITY ?auto_12031 ?auto_12036 ) ( not ( = ?auto_12031 ?auto_12029 ) ) ( TRUCK-AT ?auto_12038 ?auto_12032 ) ( OBJ-AT ?auto_12025 ?auto_12032 ) ( AIRPORT ?auto_12034 ) ( not ( = ?auto_12034 ?auto_12030 ) ) ( AIRPORT ?auto_12027 ) ( not ( = ?auto_12027 ?auto_12034 ) ) ( AIRPORT ?auto_12035 ) ( not ( = ?auto_12035 ?auto_12027 ) ) ( AIRPORT ?auto_12040 ) ( AIRPLANE-AT ?auto_12028 ?auto_12040 ) ( not ( = ?auto_12040 ?auto_12035 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_12028 ?auto_12040 ?auto_12035 )
      ( DELIVER-PKG ?auto_12025 ?auto_12026 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_7489 - OBJ
      ?auto_7490 - LOCATION
    )
    :vars
    (
      ?auto_7497 - LOCATION
      ?auto_7491 - CITY
      ?auto_7500 - LOCATION
      ?auto_7493 - LOCATION
      ?auto_7495 - LOCATION
      ?auto_7496 - LOCATION
      ?auto_7494 - LOCATION
      ?auto_7499 - LOCATION
      ?auto_7492 - AIRPLANE
      ?auto_7503 - TRUCK
      ?auto_7505 - LOCATION
      ?auto_7506 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_7497 ?auto_7491 ) ( IN-CITY ?auto_7490 ?auto_7491 ) ( not ( = ?auto_7490 ?auto_7497 ) ) ( AIRPORT ?auto_7500 ) ( AIRPORT ?auto_7497 ) ( not ( = ?auto_7500 ?auto_7497 ) ) ( OBJ-AT ?auto_7489 ?auto_7500 ) ( AIRPORT ?auto_7493 ) ( not ( = ?auto_7493 ?auto_7500 ) ) ( AIRPORT ?auto_7495 ) ( not ( = ?auto_7495 ?auto_7493 ) ) ( AIRPORT ?auto_7496 ) ( not ( = ?auto_7496 ?auto_7495 ) ) ( AIRPORT ?auto_7494 ) ( not ( = ?auto_7494 ?auto_7496 ) ) ( AIRPORT ?auto_7499 ) ( AIRPLANE-AT ?auto_7492 ?auto_7499 ) ( not ( = ?auto_7499 ?auto_7494 ) ) ( TRUCK-AT ?auto_7503 ?auto_7505 ) ( IN-CITY ?auto_7505 ?auto_7506 ) ( IN-CITY ?auto_7497 ?auto_7506 ) ( not ( = ?auto_7497 ?auto_7505 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_7503 ?auto_7505 ?auto_7497 ?auto_7506 )
      ( DELIVER-PKG ?auto_7489 ?auto_7490 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_7524 - OBJ
      ?auto_7525 - LOCATION
    )
    :vars
    (
      ?auto_7530 - LOCATION
      ?auto_7529 - CITY
      ?auto_7534 - LOCATION
      ?auto_7527 - LOCATION
      ?auto_7535 - LOCATION
      ?auto_7538 - LOCATION
      ?auto_7531 - LOCATION
      ?auto_7526 - LOCATION
      ?auto_7528 - AIRPLANE
      ?auto_7536 - LOCATION
      ?auto_7537 - CITY
      ?auto_7533 - TRUCK
      ?auto_7541 - LOCATION
      ?auto_7542 - CITY
    )
    :precondition
    ( and ( IN-CITY ?auto_7530 ?auto_7529 ) ( IN-CITY ?auto_7525 ?auto_7529 ) ( not ( = ?auto_7525 ?auto_7530 ) ) ( AIRPORT ?auto_7534 ) ( AIRPORT ?auto_7530 ) ( not ( = ?auto_7534 ?auto_7530 ) ) ( OBJ-AT ?auto_7524 ?auto_7534 ) ( AIRPORT ?auto_7527 ) ( not ( = ?auto_7527 ?auto_7534 ) ) ( AIRPORT ?auto_7535 ) ( not ( = ?auto_7535 ?auto_7527 ) ) ( AIRPORT ?auto_7538 ) ( not ( = ?auto_7538 ?auto_7535 ) ) ( AIRPORT ?auto_7531 ) ( not ( = ?auto_7531 ?auto_7538 ) ) ( AIRPORT ?auto_7526 ) ( AIRPLANE-AT ?auto_7528 ?auto_7526 ) ( not ( = ?auto_7526 ?auto_7531 ) ) ( IN-CITY ?auto_7536 ?auto_7537 ) ( IN-CITY ?auto_7530 ?auto_7537 ) ( not ( = ?auto_7530 ?auto_7536 ) ) ( TRUCK-AT ?auto_7533 ?auto_7541 ) ( IN-CITY ?auto_7541 ?auto_7542 ) ( IN-CITY ?auto_7536 ?auto_7542 ) ( not ( = ?auto_7536 ?auto_7541 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_7533 ?auto_7541 ?auto_7536 ?auto_7542 )
      ( DELIVER-PKG ?auto_7524 ?auto_7525 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_8594 - OBJ
      ?auto_8595 - LOCATION
    )
    :vars
    (
      ?auto_8606 - LOCATION
      ?auto_8598 - LOCATION
      ?auto_8599 - LOCATION
      ?auto_8608 - CITY
      ?auto_8600 - LOCATION
      ?auto_8596 - LOCATION
      ?auto_8609 - LOCATION
      ?auto_8597 - CITY
      ?auto_8603 - TRUCK
      ?auto_8601 - LOCATION
      ?auto_8605 - CITY
      ?auto_8611 - LOCATION
      ?auto_8604 - LOCATION
      ?auto_8613 - LOCATION
      ?auto_8602 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_8606 ) ( AIRPORT ?auto_8595 ) ( not ( = ?auto_8606 ?auto_8595 ) ) ( AIRPORT ?auto_8598 ) ( not ( = ?auto_8598 ?auto_8606 ) ) ( IN-CITY ?auto_8599 ?auto_8608 ) ( IN-CITY ?auto_8606 ?auto_8608 ) ( not ( = ?auto_8606 ?auto_8599 ) ) ( OBJ-AT ?auto_8594 ?auto_8599 ) ( AIRPORT ?auto_8600 ) ( not ( = ?auto_8600 ?auto_8598 ) ) ( AIRPORT ?auto_8596 ) ( not ( = ?auto_8596 ?auto_8600 ) ) ( IN-CITY ?auto_8609 ?auto_8597 ) ( IN-CITY ?auto_8599 ?auto_8597 ) ( not ( = ?auto_8599 ?auto_8609 ) ) ( TRUCK-AT ?auto_8603 ?auto_8601 ) ( IN-CITY ?auto_8601 ?auto_8605 ) ( IN-CITY ?auto_8609 ?auto_8605 ) ( not ( = ?auto_8609 ?auto_8601 ) ) ( AIRPORT ?auto_8611 ) ( not ( = ?auto_8611 ?auto_8596 ) ) ( AIRPORT ?auto_8604 ) ( not ( = ?auto_8604 ?auto_8611 ) ) ( AIRPORT ?auto_8613 ) ( AIRPLANE-AT ?auto_8602 ?auto_8613 ) ( not ( = ?auto_8613 ?auto_8604 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_8602 ?auto_8613 ?auto_8604 )
      ( DELIVER-PKG ?auto_8594 ?auto_8595 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_8634 - OBJ
      ?auto_8635 - LOCATION
    )
    :vars
    (
      ?auto_8636 - LOCATION
      ?auto_8650 - LOCATION
      ?auto_8647 - LOCATION
      ?auto_8643 - CITY
      ?auto_8638 - LOCATION
      ?auto_8646 - LOCATION
      ?auto_8644 - LOCATION
      ?auto_8645 - CITY
      ?auto_8640 - TRUCK
      ?auto_8639 - LOCATION
      ?auto_8648 - CITY
      ?auto_8637 - LOCATION
      ?auto_8642 - LOCATION
      ?auto_8652 - LOCATION
      ?auto_8654 - LOCATION
      ?auto_8641 - AIRPLANE
    )
    :precondition
    ( and ( AIRPORT ?auto_8636 ) ( AIRPORT ?auto_8635 ) ( not ( = ?auto_8636 ?auto_8635 ) ) ( AIRPORT ?auto_8650 ) ( not ( = ?auto_8650 ?auto_8636 ) ) ( IN-CITY ?auto_8647 ?auto_8643 ) ( IN-CITY ?auto_8636 ?auto_8643 ) ( not ( = ?auto_8636 ?auto_8647 ) ) ( OBJ-AT ?auto_8634 ?auto_8647 ) ( AIRPORT ?auto_8638 ) ( not ( = ?auto_8638 ?auto_8650 ) ) ( AIRPORT ?auto_8646 ) ( not ( = ?auto_8646 ?auto_8638 ) ) ( IN-CITY ?auto_8644 ?auto_8645 ) ( IN-CITY ?auto_8647 ?auto_8645 ) ( not ( = ?auto_8647 ?auto_8644 ) ) ( TRUCK-AT ?auto_8640 ?auto_8639 ) ( IN-CITY ?auto_8639 ?auto_8648 ) ( IN-CITY ?auto_8644 ?auto_8648 ) ( not ( = ?auto_8644 ?auto_8639 ) ) ( AIRPORT ?auto_8637 ) ( not ( = ?auto_8637 ?auto_8646 ) ) ( AIRPORT ?auto_8642 ) ( not ( = ?auto_8642 ?auto_8637 ) ) ( AIRPORT ?auto_8652 ) ( not ( = ?auto_8652 ?auto_8642 ) ) ( AIRPORT ?auto_8654 ) ( AIRPLANE-AT ?auto_8641 ?auto_8654 ) ( not ( = ?auto_8654 ?auto_8652 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_8641 ?auto_8654 ?auto_8652 )
      ( DELIVER-PKG ?auto_8634 ?auto_8635 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_11244 - OBJ
      ?auto_11245 - LOCATION
    )
    :vars
    (
      ?auto_11251 - TRUCK
      ?auto_11260 - LOCATION
      ?auto_11252 - CITY
      ?auto_11254 - LOCATION
      ?auto_11253 - LOCATION
      ?auto_11249 - LOCATION
      ?auto_11256 - LOCATION
      ?auto_11259 - CITY
      ?auto_11250 - LOCATION
      ?auto_11258 - CITY
      ?auto_11246 - LOCATION
      ?auto_11261 - LOCATION
      ?auto_11248 - AIRPLANE
      ?auto_11255 - TRUCK
      ?auto_11263 - LOCATION
      ?auto_11264 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_11251 ?auto_11260 ) ( IN-CITY ?auto_11260 ?auto_11252 ) ( IN-CITY ?auto_11245 ?auto_11252 ) ( not ( = ?auto_11245 ?auto_11260 ) ) ( TRUCK-AT ?auto_11251 ?auto_11254 ) ( AIRPORT ?auto_11253 ) ( AIRPORT ?auto_11254 ) ( not ( = ?auto_11253 ?auto_11254 ) ) ( AIRPORT ?auto_11249 ) ( not ( = ?auto_11249 ?auto_11253 ) ) ( IN-CITY ?auto_11256 ?auto_11259 ) ( IN-CITY ?auto_11253 ?auto_11259 ) ( not ( = ?auto_11253 ?auto_11256 ) ) ( OBJ-AT ?auto_11244 ?auto_11256 ) ( IN-CITY ?auto_11250 ?auto_11258 ) ( IN-CITY ?auto_11256 ?auto_11258 ) ( not ( = ?auto_11256 ?auto_11250 ) ) ( AIRPORT ?auto_11246 ) ( not ( = ?auto_11246 ?auto_11249 ) ) ( AIRPORT ?auto_11261 ) ( AIRPLANE-AT ?auto_11248 ?auto_11261 ) ( not ( = ?auto_11261 ?auto_11246 ) ) ( TRUCK-AT ?auto_11255 ?auto_11263 ) ( IN-CITY ?auto_11263 ?auto_11264 ) ( IN-CITY ?auto_11250 ?auto_11264 ) ( not ( = ?auto_11250 ?auto_11263 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_11255 ?auto_11263 ?auto_11250 ?auto_11264 )
      ( DELIVER-PKG ?auto_11244 ?auto_11245 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_12319 - OBJ
      ?auto_12320 - LOCATION
    )
    :vars
    (
      ?auto_12329 - LOCATION
      ?auto_12326 - CITY
      ?auto_12324 - TRUCK
      ?auto_12330 - LOCATION
      ?auto_12322 - CITY
      ?auto_12323 - LOCATION
      ?auto_12327 - LOCATION
      ?auto_12335 - TRUCK
      ?auto_12333 - LOCATION
      ?auto_12336 - CITY
      ?auto_12325 - LOCATION
      ?auto_12334 - LOCATION
      ?auto_12331 - LOCATION
      ?auto_12338 - LOCATION
      ?auto_12321 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_12329 ?auto_12326 ) ( IN-CITY ?auto_12320 ?auto_12326 ) ( not ( = ?auto_12320 ?auto_12329 ) ) ( TRUCK-AT ?auto_12324 ?auto_12330 ) ( IN-CITY ?auto_12330 ?auto_12322 ) ( IN-CITY ?auto_12329 ?auto_12322 ) ( not ( = ?auto_12329 ?auto_12330 ) ) ( AIRPORT ?auto_12323 ) ( AIRPORT ?auto_12329 ) ( not ( = ?auto_12323 ?auto_12329 ) ) ( AIRPORT ?auto_12327 ) ( not ( = ?auto_12327 ?auto_12323 ) ) ( TRUCK-AT ?auto_12335 ?auto_12333 ) ( IN-CITY ?auto_12333 ?auto_12336 ) ( IN-CITY ?auto_12323 ?auto_12336 ) ( not ( = ?auto_12323 ?auto_12333 ) ) ( TRUCK-AT ?auto_12335 ?auto_12325 ) ( OBJ-AT ?auto_12319 ?auto_12325 ) ( AIRPORT ?auto_12334 ) ( not ( = ?auto_12334 ?auto_12327 ) ) ( AIRPORT ?auto_12331 ) ( not ( = ?auto_12331 ?auto_12334 ) ) ( AIRPORT ?auto_12338 ) ( AIRPLANE-AT ?auto_12321 ?auto_12338 ) ( not ( = ?auto_12338 ?auto_12331 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_12321 ?auto_12338 ?auto_12331 )
      ( DELIVER-PKG ?auto_12319 ?auto_12320 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_12359 - OBJ
      ?auto_12360 - LOCATION
    )
    :vars
    (
      ?auto_12362 - LOCATION
      ?auto_12364 - CITY
      ?auto_12371 - TRUCK
      ?auto_12369 - LOCATION
      ?auto_12374 - CITY
      ?auto_12376 - LOCATION
      ?auto_12368 - LOCATION
      ?auto_12367 - TRUCK
      ?auto_12366 - LOCATION
      ?auto_12365 - CITY
      ?auto_12363 - LOCATION
      ?auto_12361 - LOCATION
      ?auto_12375 - LOCATION
      ?auto_12373 - LOCATION
      ?auto_12379 - LOCATION
      ?auto_12370 - AIRPLANE
    )
    :precondition
    ( and ( IN-CITY ?auto_12362 ?auto_12364 ) ( IN-CITY ?auto_12360 ?auto_12364 ) ( not ( = ?auto_12360 ?auto_12362 ) ) ( TRUCK-AT ?auto_12371 ?auto_12369 ) ( IN-CITY ?auto_12369 ?auto_12374 ) ( IN-CITY ?auto_12362 ?auto_12374 ) ( not ( = ?auto_12362 ?auto_12369 ) ) ( AIRPORT ?auto_12376 ) ( AIRPORT ?auto_12362 ) ( not ( = ?auto_12376 ?auto_12362 ) ) ( AIRPORT ?auto_12368 ) ( not ( = ?auto_12368 ?auto_12376 ) ) ( TRUCK-AT ?auto_12367 ?auto_12366 ) ( IN-CITY ?auto_12366 ?auto_12365 ) ( IN-CITY ?auto_12376 ?auto_12365 ) ( not ( = ?auto_12376 ?auto_12366 ) ) ( TRUCK-AT ?auto_12367 ?auto_12363 ) ( OBJ-AT ?auto_12359 ?auto_12363 ) ( AIRPORT ?auto_12361 ) ( not ( = ?auto_12361 ?auto_12368 ) ) ( AIRPORT ?auto_12375 ) ( not ( = ?auto_12375 ?auto_12361 ) ) ( AIRPORT ?auto_12373 ) ( not ( = ?auto_12373 ?auto_12375 ) ) ( AIRPORT ?auto_12379 ) ( AIRPLANE-AT ?auto_12370 ?auto_12379 ) ( not ( = ?auto_12379 ?auto_12373 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_12370 ?auto_12379 ?auto_12373 )
      ( DELIVER-PKG ?auto_12359 ?auto_12360 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_12917 - OBJ
      ?auto_12918 - LOCATION
    )
    :vars
    (
      ?auto_12926 - LOCATION
      ?auto_12922 - AIRPLANE
      ?auto_12927 - LOCATION
      ?auto_12919 - LOCATION
      ?auto_12924 - CITY
      ?auto_12925 - LOCATION
      ?auto_12923 - CITY
      ?auto_12921 - TRUCK
      ?auto_12930 - LOCATION
      ?auto_12931 - CITY
    )
    :precondition
    ( and ( AIRPORT ?auto_12926 ) ( AIRPORT ?auto_12918 ) ( AIRPLANE-AT ?auto_12922 ?auto_12926 ) ( not ( = ?auto_12926 ?auto_12918 ) ) ( AIRPLANE-AT ?auto_12922 ?auto_12927 ) ( IN-CITY ?auto_12919 ?auto_12924 ) ( IN-CITY ?auto_12927 ?auto_12924 ) ( not ( = ?auto_12927 ?auto_12919 ) ) ( OBJ-AT ?auto_12917 ?auto_12919 ) ( IN-CITY ?auto_12925 ?auto_12923 ) ( IN-CITY ?auto_12919 ?auto_12923 ) ( not ( = ?auto_12919 ?auto_12925 ) ) ( TRUCK-AT ?auto_12921 ?auto_12930 ) ( IN-CITY ?auto_12930 ?auto_12931 ) ( IN-CITY ?auto_12925 ?auto_12931 ) ( not ( = ?auto_12925 ?auto_12930 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_12921 ?auto_12930 ?auto_12925 ?auto_12931 )
      ( DELIVER-PKG ?auto_12917 ?auto_12918 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13117 - OBJ
      ?auto_13118 - LOCATION
    )
    :vars
    (
      ?auto_13120 - TRUCK
      ?auto_13121 - LOCATION
      ?auto_13127 - CITY
      ?auto_13126 - LOCATION
      ?auto_13119 - LOCATION
      ?auto_13125 - AIRPLANE
      ?auto_13122 - LOCATION
      ?auto_13129 - TRUCK
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13120 ?auto_13121 ) ( IN-CITY ?auto_13121 ?auto_13127 ) ( IN-CITY ?auto_13118 ?auto_13127 ) ( not ( = ?auto_13118 ?auto_13121 ) ) ( TRUCK-AT ?auto_13120 ?auto_13126 ) ( AIRPORT ?auto_13119 ) ( AIRPORT ?auto_13126 ) ( AIRPLANE-AT ?auto_13125 ?auto_13119 ) ( not ( = ?auto_13119 ?auto_13126 ) ) ( AIRPLANE-AT ?auto_13125 ?auto_13122 ) ( TRUCK-AT ?auto_13129 ?auto_13122 ) ( IN-TRUCK ?auto_13117 ?auto_13129 ) )
    :subtasks
    ( ( DELIVER-PKG ?auto_13117 ?auto_13122 )
      ( DELIVER-PKG ?auto_13117 ?auto_13118 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13131 - OBJ
      ?auto_13132 - LOCATION
    )
    :vars
    (
      ?auto_13141 - TRUCK
      ?auto_13136 - LOCATION
      ?auto_13137 - CITY
      ?auto_13138 - LOCATION
      ?auto_13142 - LOCATION
      ?auto_13134 - AIRPLANE
      ?auto_13135 - LOCATION
      ?auto_13133 - TRUCK
      ?auto_13144 - LOCATION
      ?auto_13145 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13141 ?auto_13136 ) ( IN-CITY ?auto_13136 ?auto_13137 ) ( IN-CITY ?auto_13132 ?auto_13137 ) ( not ( = ?auto_13132 ?auto_13136 ) ) ( TRUCK-AT ?auto_13141 ?auto_13138 ) ( AIRPORT ?auto_13142 ) ( AIRPORT ?auto_13138 ) ( AIRPLANE-AT ?auto_13134 ?auto_13142 ) ( not ( = ?auto_13142 ?auto_13138 ) ) ( AIRPLANE-AT ?auto_13134 ?auto_13135 ) ( IN-TRUCK ?auto_13131 ?auto_13133 ) ( TRUCK-AT ?auto_13133 ?auto_13144 ) ( IN-CITY ?auto_13144 ?auto_13145 ) ( IN-CITY ?auto_13135 ?auto_13145 ) ( not ( = ?auto_13135 ?auto_13144 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_13133 ?auto_13144 ?auto_13135 ?auto_13145 )
      ( DELIVER-PKG ?auto_13131 ?auto_13132 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13147 - OBJ
      ?auto_13148 - LOCATION
    )
    :vars
    (
      ?auto_13154 - TRUCK
      ?auto_13150 - LOCATION
      ?auto_13152 - CITY
      ?auto_13153 - LOCATION
      ?auto_13158 - LOCATION
      ?auto_13156 - AIRPLANE
      ?auto_13151 - LOCATION
      ?auto_13155 - TRUCK
      ?auto_13159 - LOCATION
      ?auto_13160 - CITY
      ?auto_13162 - LOCATION
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13154 ?auto_13150 ) ( IN-CITY ?auto_13150 ?auto_13152 ) ( IN-CITY ?auto_13148 ?auto_13152 ) ( not ( = ?auto_13148 ?auto_13150 ) ) ( TRUCK-AT ?auto_13154 ?auto_13153 ) ( AIRPORT ?auto_13158 ) ( AIRPORT ?auto_13153 ) ( AIRPLANE-AT ?auto_13156 ?auto_13158 ) ( not ( = ?auto_13158 ?auto_13153 ) ) ( AIRPLANE-AT ?auto_13156 ?auto_13151 ) ( TRUCK-AT ?auto_13155 ?auto_13159 ) ( IN-CITY ?auto_13159 ?auto_13160 ) ( IN-CITY ?auto_13151 ?auto_13160 ) ( not ( = ?auto_13151 ?auto_13159 ) ) ( TRUCK-AT ?auto_13155 ?auto_13162 ) ( OBJ-AT ?auto_13147 ?auto_13162 ) )
    :subtasks
    ( ( !LOAD-TRUCK ?auto_13147 ?auto_13155 ?auto_13162 )
      ( DELIVER-PKG ?auto_13147 ?auto_13148 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13179 - OBJ
      ?auto_13180 - LOCATION
    )
    :vars
    (
      ?auto_13186 - TRUCK
      ?auto_13188 - LOCATION
      ?auto_13187 - CITY
      ?auto_13190 - LOCATION
      ?auto_13193 - LOCATION
      ?auto_13181 - AIRPLANE
      ?auto_13189 - LOCATION
      ?auto_13184 - LOCATION
      ?auto_13192 - CITY
      ?auto_13185 - TRUCK
      ?auto_13195 - LOCATION
      ?auto_13196 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13186 ?auto_13188 ) ( IN-CITY ?auto_13188 ?auto_13187 ) ( IN-CITY ?auto_13180 ?auto_13187 ) ( not ( = ?auto_13180 ?auto_13188 ) ) ( TRUCK-AT ?auto_13186 ?auto_13190 ) ( AIRPORT ?auto_13193 ) ( AIRPORT ?auto_13190 ) ( AIRPLANE-AT ?auto_13181 ?auto_13193 ) ( not ( = ?auto_13193 ?auto_13190 ) ) ( AIRPLANE-AT ?auto_13181 ?auto_13189 ) ( IN-CITY ?auto_13184 ?auto_13192 ) ( IN-CITY ?auto_13189 ?auto_13192 ) ( not ( = ?auto_13189 ?auto_13184 ) ) ( OBJ-AT ?auto_13179 ?auto_13184 ) ( TRUCK-AT ?auto_13185 ?auto_13195 ) ( IN-CITY ?auto_13195 ?auto_13196 ) ( IN-CITY ?auto_13184 ?auto_13196 ) ( not ( = ?auto_13184 ?auto_13195 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_13185 ?auto_13195 ?auto_13184 ?auto_13196 )
      ( DELIVER-PKG ?auto_13179 ?auto_13180 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13214 - OBJ
      ?auto_13215 - LOCATION
    )
    :vars
    (
      ?auto_13224 - TRUCK
      ?auto_13218 - LOCATION
      ?auto_13222 - CITY
      ?auto_13228 - LOCATION
      ?auto_13225 - LOCATION
      ?auto_13219 - AIRPLANE
      ?auto_13221 - LOCATION
      ?auto_13217 - LOCATION
      ?auto_13227 - CITY
      ?auto_13220 - LOCATION
      ?auto_13216 - CITY
      ?auto_13229 - TRUCK
      ?auto_13231 - LOCATION
      ?auto_13232 - CITY
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13224 ?auto_13218 ) ( IN-CITY ?auto_13218 ?auto_13222 ) ( IN-CITY ?auto_13215 ?auto_13222 ) ( not ( = ?auto_13215 ?auto_13218 ) ) ( TRUCK-AT ?auto_13224 ?auto_13228 ) ( AIRPORT ?auto_13225 ) ( AIRPORT ?auto_13228 ) ( AIRPLANE-AT ?auto_13219 ?auto_13225 ) ( not ( = ?auto_13225 ?auto_13228 ) ) ( AIRPLANE-AT ?auto_13219 ?auto_13221 ) ( IN-CITY ?auto_13217 ?auto_13227 ) ( IN-CITY ?auto_13221 ?auto_13227 ) ( not ( = ?auto_13221 ?auto_13217 ) ) ( OBJ-AT ?auto_13214 ?auto_13217 ) ( IN-CITY ?auto_13220 ?auto_13216 ) ( IN-CITY ?auto_13217 ?auto_13216 ) ( not ( = ?auto_13217 ?auto_13220 ) ) ( TRUCK-AT ?auto_13229 ?auto_13231 ) ( IN-CITY ?auto_13231 ?auto_13232 ) ( IN-CITY ?auto_13220 ?auto_13232 ) ( not ( = ?auto_13220 ?auto_13231 ) ) )
    :subtasks
    ( ( !DRIVE-TRUCK ?auto_13229 ?auto_13231 ?auto_13220 ?auto_13232 )
      ( DELIVER-PKG ?auto_13214 ?auto_13215 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13252 - OBJ
      ?auto_13253 - LOCATION
    )
    :vars
    (
      ?auto_13267 - TRUCK
      ?auto_13268 - LOCATION
      ?auto_13266 - CITY
      ?auto_13254 - LOCATION
      ?auto_13261 - LOCATION
      ?auto_13262 - LOCATION
      ?auto_13255 - CITY
      ?auto_13265 - LOCATION
      ?auto_13256 - CITY
      ?auto_13257 - TRUCK
      ?auto_13264 - LOCATION
      ?auto_13263 - CITY
      ?auto_13271 - LOCATION
      ?auto_13258 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13267 ?auto_13268 ) ( IN-CITY ?auto_13268 ?auto_13266 ) ( IN-CITY ?auto_13253 ?auto_13266 ) ( not ( = ?auto_13253 ?auto_13268 ) ) ( TRUCK-AT ?auto_13267 ?auto_13254 ) ( AIRPORT ?auto_13261 ) ( AIRPORT ?auto_13254 ) ( not ( = ?auto_13261 ?auto_13254 ) ) ( IN-CITY ?auto_13262 ?auto_13255 ) ( IN-CITY ?auto_13261 ?auto_13255 ) ( not ( = ?auto_13261 ?auto_13262 ) ) ( OBJ-AT ?auto_13252 ?auto_13262 ) ( IN-CITY ?auto_13265 ?auto_13256 ) ( IN-CITY ?auto_13262 ?auto_13256 ) ( not ( = ?auto_13262 ?auto_13265 ) ) ( TRUCK-AT ?auto_13257 ?auto_13264 ) ( IN-CITY ?auto_13264 ?auto_13263 ) ( IN-CITY ?auto_13265 ?auto_13263 ) ( not ( = ?auto_13265 ?auto_13264 ) ) ( AIRPORT ?auto_13271 ) ( AIRPLANE-AT ?auto_13258 ?auto_13271 ) ( not ( = ?auto_13271 ?auto_13261 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_13258 ?auto_13271 ?auto_13261 )
      ( DELIVER-PKG ?auto_13252 ?auto_13253 ) )
  )

  ( :method DELIVER-PKG
    :parameters
    (
      ?auto_13291 - OBJ
      ?auto_13292 - LOCATION
    )
    :vars
    (
      ?auto_13301 - TRUCK
      ?auto_13295 - LOCATION
      ?auto_13305 - CITY
      ?auto_13306 - LOCATION
      ?auto_13300 - LOCATION
      ?auto_13303 - LOCATION
      ?auto_13302 - CITY
      ?auto_13294 - LOCATION
      ?auto_13297 - CITY
      ?auto_13298 - TRUCK
      ?auto_13304 - LOCATION
      ?auto_13296 - CITY
      ?auto_13293 - LOCATION
      ?auto_13310 - LOCATION
      ?auto_13299 - AIRPLANE
    )
    :precondition
    ( and ( TRUCK-AT ?auto_13301 ?auto_13295 ) ( IN-CITY ?auto_13295 ?auto_13305 ) ( IN-CITY ?auto_13292 ?auto_13305 ) ( not ( = ?auto_13292 ?auto_13295 ) ) ( TRUCK-AT ?auto_13301 ?auto_13306 ) ( AIRPORT ?auto_13300 ) ( AIRPORT ?auto_13306 ) ( not ( = ?auto_13300 ?auto_13306 ) ) ( IN-CITY ?auto_13303 ?auto_13302 ) ( IN-CITY ?auto_13300 ?auto_13302 ) ( not ( = ?auto_13300 ?auto_13303 ) ) ( OBJ-AT ?auto_13291 ?auto_13303 ) ( IN-CITY ?auto_13294 ?auto_13297 ) ( IN-CITY ?auto_13303 ?auto_13297 ) ( not ( = ?auto_13303 ?auto_13294 ) ) ( TRUCK-AT ?auto_13298 ?auto_13304 ) ( IN-CITY ?auto_13304 ?auto_13296 ) ( IN-CITY ?auto_13294 ?auto_13296 ) ( not ( = ?auto_13294 ?auto_13304 ) ) ( AIRPORT ?auto_13293 ) ( not ( = ?auto_13293 ?auto_13300 ) ) ( AIRPORT ?auto_13310 ) ( AIRPLANE-AT ?auto_13299 ?auto_13310 ) ( not ( = ?auto_13310 ?auto_13293 ) ) )
    :subtasks
    ( ( !FLY-AIRPLANE ?auto_13299 ?auto_13310 ?auto_13293 )
      ( DELIVER-PKG ?auto_13291 ?auto_13292 ) )
  )

)

