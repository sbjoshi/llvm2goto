; ModuleID = '2003-05-02-DependentPHI.c'
source_filename = "2003-05-02-DependentPHI.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.List = type { %struct.List*, i32 }

@Node0 = global %struct.List { %struct.List* null, i32 5 }, align 8, !dbg !0
@Node1 = global %struct.List { %struct.List* @Node0, i32 4 }, align 8, !dbg !6
@Node2 = global %struct.List { %struct.List* @Node1, i32 3 }, align 8, !dbg !15
@Node3 = global %struct.List { %struct.List* @Node2, i32 2 }, align 8, !dbg !17
@Node4 = global %struct.List { %struct.List* @Node3, i32 1 }, align 8, !dbg !19
@Node5 = global %struct.List { %struct.List* @Node4, i32 0 }, align 8, !dbg !21
@.str = private unnamed_addr constant [7 x i8] c"%d %d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !27 {
entry:
  %retval = alloca i32, align 4
  %PrevL = alloca %struct.List*, align 8
  %CurL = alloca %struct.List*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.List** %PrevL, metadata !30, metadata !32), !dbg !33
  call void @llvm.dbg.declare(metadata %struct.List** %CurL, metadata !34, metadata !32), !dbg !35
  store %struct.List* null, %struct.List** %PrevL, align 8, !dbg !36
  store %struct.List* @Node5, %struct.List** %CurL, align 8, !dbg !38
  br label %for.cond, !dbg !39

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load %struct.List*, %struct.List** %CurL, align 8, !dbg !40
  %tobool = icmp ne %struct.List* %0, null, !dbg !42
  br i1 %tobool, label %for.body, label %for.end, !dbg !42

for.body:                                         ; preds = %for.cond
  %1 = load %struct.List*, %struct.List** %CurL, align 8, !dbg !43
  %Data = getelementptr inbounds %struct.List, %struct.List* %1, i32 0, i32 1, !dbg !45
  %2 = load i32, i32* %Data, align 8, !dbg !45
  %3 = load %struct.List*, %struct.List** %PrevL, align 8, !dbg !46
  %tobool1 = icmp ne %struct.List* %3, null, !dbg !46
  br i1 %tobool1, label %cond.true, label %cond.false, !dbg !46

cond.true:                                        ; preds = %for.body
  %4 = load %struct.List*, %struct.List** %PrevL, align 8, !dbg !47
  %Data2 = getelementptr inbounds %struct.List, %struct.List* %4, i32 0, i32 1, !dbg !48
  %5 = load i32, i32* %Data2, align 8, !dbg !48
  br label %cond.end, !dbg !46

cond.false:                                       ; preds = %for.body
  br label %cond.end, !dbg !46

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %5, %cond.true ], [ -1, %cond.false ], !dbg !46
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i32 %2, i32 %cond), !dbg !49
  br label %for.inc, !dbg !50

for.inc:                                          ; preds = %cond.end
  %6 = load %struct.List*, %struct.List** %CurL, align 8, !dbg !51
  store %struct.List* %6, %struct.List** %PrevL, align 8, !dbg !52
  %7 = load %struct.List*, %struct.List** %CurL, align 8, !dbg !53
  %Next = getelementptr inbounds %struct.List, %struct.List* %7, i32 0, i32 0, !dbg !54
  %8 = load %struct.List*, %struct.List** %Next, align 8, !dbg !54
  store %struct.List* %8, %struct.List** %CurL, align 8, !dbg !55
  br label %for.cond, !dbg !56, !llvm.loop !57

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !59
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @printf(i8*, ...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!23, !24, !25}
!llvm.ident = !{!26}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "Node0", scope: !2, file: !3, line: 8, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "2003-05-02-DependentPHI.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!4 = !{}
!5 = !{!0, !6, !15, !17, !19, !21}
!6 = !DIGlobalVariableExpression(var: !7)
!7 = distinct !DIGlobalVariable(name: "Node1", scope: !2, file: !3, line: 9, type: !8, isLocal: false, isDefinition: true)
!8 = !DIDerivedType(tag: DW_TAG_typedef, name: "List", file: !3, line: 6, baseType: !9)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "List", file: !3, line: 3, size: 128, elements: !10)
!10 = !{!11, !13}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "Next", scope: !9, file: !3, line: 4, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_member, name: "Data", scope: !9, file: !3, line: 5, baseType: !14, size: 32, offset: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIGlobalVariableExpression(var: !16)
!16 = distinct !DIGlobalVariable(name: "Node2", scope: !2, file: !3, line: 10, type: !8, isLocal: false, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18)
!18 = distinct !DIGlobalVariable(name: "Node3", scope: !2, file: !3, line: 11, type: !8, isLocal: false, isDefinition: true)
!19 = !DIGlobalVariableExpression(var: !20)
!20 = distinct !DIGlobalVariable(name: "Node4", scope: !2, file: !3, line: 12, type: !8, isLocal: false, isDefinition: true)
!21 = !DIGlobalVariableExpression(var: !22)
!22 = distinct !DIGlobalVariable(name: "Node5", scope: !2, file: !3, line: 13, type: !8, isLocal: false, isDefinition: true)
!23 = !{i32 2, !"Dwarf Version", i32 4}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!27 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 16, type: !28, isLocal: false, isDefinition: true, scopeLine: 16, isOptimized: false, unit: !2, variables: !4)
!28 = !DISubroutineType(types: !29)
!29 = !{!14}
!30 = !DILocalVariable(name: "PrevL", scope: !27, file: !3, line: 17, type: !31)
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!32 = !DIExpression()
!33 = !DILocation(line: 17, column: 11, scope: !27)
!34 = !DILocalVariable(name: "CurL", scope: !27, file: !3, line: 17, type: !31)
!35 = !DILocation(line: 17, column: 19, scope: !27)
!36 = !DILocation(line: 18, column: 16, scope: !37)
!37 = distinct !DILexicalBlock(scope: !27, file: !3, line: 18, column: 5)
!38 = !DILocation(line: 18, column: 26, scope: !37)
!39 = !DILocation(line: 18, column: 10, scope: !37)
!40 = !DILocation(line: 18, column: 36, scope: !41)
!41 = distinct !DILexicalBlock(scope: !37, file: !3, line: 18, column: 5)
!42 = !DILocation(line: 18, column: 5, scope: !37)
!43 = !DILocation(line: 19, column: 20, scope: !44)
!44 = distinct !DILexicalBlock(scope: !41, file: !3, line: 18, column: 75)
!45 = !DILocation(line: 19, column: 26, scope: !44)
!46 = !DILocation(line: 19, column: 32, scope: !44)
!47 = !DILocation(line: 19, column: 40, scope: !44)
!48 = !DILocation(line: 19, column: 47, scope: !44)
!49 = !DILocation(line: 19, column: 2, scope: !44)
!50 = !DILocation(line: 20, column: 5, scope: !44)
!51 = !DILocation(line: 18, column: 50, scope: !41)
!52 = !DILocation(line: 18, column: 48, scope: !41)
!53 = !DILocation(line: 18, column: 63, scope: !41)
!54 = !DILocation(line: 18, column: 69, scope: !41)
!55 = !DILocation(line: 18, column: 61, scope: !41)
!56 = !DILocation(line: 18, column: 5, scope: !41)
!57 = distinct !{!57, !42, !58}
!58 = !DILocation(line: 20, column: 5, scope: !37)
!59 = !DILocation(line: 21, column: 5, scope: !27)
