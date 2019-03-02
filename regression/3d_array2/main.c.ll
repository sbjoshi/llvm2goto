; ModuleID = 'main.c'
source_filename = "main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %arr1 = alloca [2 x [3 x [4 x i32]]], align 16
  %arr2 = alloca [2 x [3 x [4 x i32]]], align 16
  %x = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %arr3 = alloca [2 x [3 x [4 x i32]]], align 16
  %i24 = alloca i32, align 4
  %j28 = alloca i32, align 4
  %k32 = alloca i32, align 4
  %i63 = alloca i32, align 4
  %j67 = alloca i32, align 4
  %k71 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr1, metadata !11, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr2, metadata !19, metadata !DIExpression()), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %x, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 1, i32* %x, align 4, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %i, metadata !23, metadata !DIExpression()), !dbg !25
  store i32 0, i32* %i, align 4, !dbg !25
  br label %for.cond, !dbg !26

for.cond:                                         ; preds = %for.inc21, %entry
  %0 = load i32, i32* %i, align 4, !dbg !27
  %cmp = icmp slt i32 %0, 2, !dbg !29
  br i1 %cmp, label %for.body, label %for.end23, !dbg !30

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !31, metadata !DIExpression()), !dbg !34
  store i32 0, i32* %j, align 4, !dbg !34
  br label %for.cond1, !dbg !35

for.cond1:                                        ; preds = %for.inc18, %for.body
  %1 = load i32, i32* %j, align 4, !dbg !36
  %cmp2 = icmp slt i32 %1, 3, !dbg !38
  br i1 %cmp2, label %for.body3, label %for.end20, !dbg !39

for.body3:                                        ; preds = %for.cond1
  call void @llvm.dbg.declare(metadata i32* %k, metadata !40, metadata !DIExpression()), !dbg !43
  store i32 0, i32* %k, align 4, !dbg !43
  br label %for.cond4, !dbg !44

for.cond4:                                        ; preds = %for.inc, %for.body3
  %2 = load i32, i32* %k, align 4, !dbg !45
  %cmp5 = icmp slt i32 %2, 4, !dbg !47
  br i1 %cmp5, label %for.body6, label %for.end, !dbg !48

for.body6:                                        ; preds = %for.cond4
  %3 = load i32, i32* %x, align 4, !dbg !49
  %4 = load i32, i32* %i, align 4, !dbg !51
  %idxprom = sext i32 %4 to i64, !dbg !52
  %arrayidx = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom, !dbg !52
  %5 = load i32, i32* %j, align 4, !dbg !53
  %idxprom7 = sext i32 %5 to i64, !dbg !52
  %arrayidx8 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx, i64 0, i64 %idxprom7, !dbg !52
  %6 = load i32, i32* %k, align 4, !dbg !54
  %idxprom9 = sext i32 %6 to i64, !dbg !52
  %arrayidx10 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx8, i64 0, i64 %idxprom9, !dbg !52
  store i32 %3, i32* %arrayidx10, align 4, !dbg !55
  %7 = load i32, i32* %x, align 4, !dbg !56
  %8 = load i32, i32* %i, align 4, !dbg !57
  %idxprom11 = sext i32 %8 to i64, !dbg !58
  %arrayidx12 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom11, !dbg !58
  %9 = load i32, i32* %j, align 4, !dbg !59
  %idxprom13 = sext i32 %9 to i64, !dbg !58
  %arrayidx14 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx12, i64 0, i64 %idxprom13, !dbg !58
  %10 = load i32, i32* %k, align 4, !dbg !60
  %idxprom15 = sext i32 %10 to i64, !dbg !58
  %arrayidx16 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx14, i64 0, i64 %idxprom15, !dbg !58
  store i32 %7, i32* %arrayidx16, align 4, !dbg !61
  %11 = load i32, i32* %x, align 4, !dbg !62
  %inc = add i32 %11, 1, !dbg !62
  store i32 %inc, i32* %x, align 4, !dbg !62
  br label %for.inc, !dbg !63

for.inc:                                          ; preds = %for.body6
  %12 = load i32, i32* %k, align 4, !dbg !64
  %inc17 = add nsw i32 %12, 1, !dbg !64
  store i32 %inc17, i32* %k, align 4, !dbg !64
  br label %for.cond4, !dbg !65, !llvm.loop !66

for.end:                                          ; preds = %for.cond4
  br label %for.inc18, !dbg !68

for.inc18:                                        ; preds = %for.end
  %13 = load i32, i32* %j, align 4, !dbg !69
  %inc19 = add nsw i32 %13, 1, !dbg !69
  store i32 %inc19, i32* %j, align 4, !dbg !69
  br label %for.cond1, !dbg !70, !llvm.loop !71

for.end20:                                        ; preds = %for.cond1
  br label %for.inc21, !dbg !73

for.inc21:                                        ; preds = %for.end20
  %14 = load i32, i32* %i, align 4, !dbg !74
  %inc22 = add nsw i32 %14, 1, !dbg !74
  store i32 %inc22, i32* %i, align 4, !dbg !74
  br label %for.cond, !dbg !75, !llvm.loop !76

for.end23:                                        ; preds = %for.cond
  call void @llvm.dbg.declare(metadata [2 x [3 x [4 x i32]]]* %arr3, metadata !78, metadata !DIExpression()), !dbg !79
  call void @llvm.dbg.declare(metadata i32* %i24, metadata !80, metadata !DIExpression()), !dbg !82
  store i32 0, i32* %i24, align 4, !dbg !82
  br label %for.cond25, !dbg !83

for.cond25:                                       ; preds = %for.inc60, %for.end23
  %15 = load i32, i32* %i24, align 4, !dbg !84
  %cmp26 = icmp slt i32 %15, 2, !dbg !86
  br i1 %cmp26, label %for.body27, label %for.end62, !dbg !87

for.body27:                                       ; preds = %for.cond25
  call void @llvm.dbg.declare(metadata i32* %j28, metadata !88, metadata !DIExpression()), !dbg !91
  store i32 0, i32* %j28, align 4, !dbg !91
  br label %for.cond29, !dbg !92

for.cond29:                                       ; preds = %for.inc57, %for.body27
  %16 = load i32, i32* %j28, align 4, !dbg !93
  %cmp30 = icmp slt i32 %16, 3, !dbg !95
  br i1 %cmp30, label %for.body31, label %for.end59, !dbg !96

for.body31:                                       ; preds = %for.cond29
  call void @llvm.dbg.declare(metadata i32* %k32, metadata !97, metadata !DIExpression()), !dbg !100
  store i32 0, i32* %k32, align 4, !dbg !100
  br label %for.cond33, !dbg !101

for.cond33:                                       ; preds = %for.inc54, %for.body31
  %17 = load i32, i32* %k32, align 4, !dbg !102
  %cmp34 = icmp slt i32 %17, 4, !dbg !104
  br i1 %cmp34, label %for.body35, label %for.end56, !dbg !105

for.body35:                                       ; preds = %for.cond33
  %18 = load i32, i32* %i24, align 4, !dbg !106
  %idxprom36 = sext i32 %18 to i64, !dbg !108
  %arrayidx37 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom36, !dbg !108
  %19 = load i32, i32* %j28, align 4, !dbg !109
  %idxprom38 = sext i32 %19 to i64, !dbg !108
  %arrayidx39 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx37, i64 0, i64 %idxprom38, !dbg !108
  %20 = load i32, i32* %k32, align 4, !dbg !110
  %idxprom40 = sext i32 %20 to i64, !dbg !108
  %arrayidx41 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx39, i64 0, i64 %idxprom40, !dbg !108
  %21 = load i32, i32* %arrayidx41, align 4, !dbg !108
  %22 = load i32, i32* %i24, align 4, !dbg !111
  %idxprom42 = sext i32 %22 to i64, !dbg !112
  %arrayidx43 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom42, !dbg !112
  %23 = load i32, i32* %j28, align 4, !dbg !113
  %idxprom44 = sext i32 %23 to i64, !dbg !112
  %arrayidx45 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx43, i64 0, i64 %idxprom44, !dbg !112
  %24 = load i32, i32* %k32, align 4, !dbg !114
  %idxprom46 = sext i32 %24 to i64, !dbg !112
  %arrayidx47 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx45, i64 0, i64 %idxprom46, !dbg !112
  %25 = load i32, i32* %arrayidx47, align 4, !dbg !112
  %add = add i32 %21, %25, !dbg !115
  %26 = load i32, i32* %i24, align 4, !dbg !116
  %idxprom48 = sext i32 %26 to i64, !dbg !117
  %arrayidx49 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom48, !dbg !117
  %27 = load i32, i32* %j28, align 4, !dbg !118
  %idxprom50 = sext i32 %27 to i64, !dbg !117
  %arrayidx51 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx49, i64 0, i64 %idxprom50, !dbg !117
  %28 = load i32, i32* %k32, align 4, !dbg !119
  %idxprom52 = sext i32 %28 to i64, !dbg !117
  %arrayidx53 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx51, i64 0, i64 %idxprom52, !dbg !117
  store i32 %add, i32* %arrayidx53, align 4, !dbg !120
  br label %for.inc54, !dbg !121

for.inc54:                                        ; preds = %for.body35
  %29 = load i32, i32* %k32, align 4, !dbg !122
  %inc55 = add nsw i32 %29, 1, !dbg !122
  store i32 %inc55, i32* %k32, align 4, !dbg !122
  br label %for.cond33, !dbg !123, !llvm.loop !124

for.end56:                                        ; preds = %for.cond33
  br label %for.inc57, !dbg !126

for.inc57:                                        ; preds = %for.end56
  %30 = load i32, i32* %j28, align 4, !dbg !127
  %inc58 = add nsw i32 %30, 1, !dbg !127
  store i32 %inc58, i32* %j28, align 4, !dbg !127
  br label %for.cond29, !dbg !128, !llvm.loop !129

for.end59:                                        ; preds = %for.cond29
  br label %for.inc60, !dbg !131

for.inc60:                                        ; preds = %for.end59
  %31 = load i32, i32* %i24, align 4, !dbg !132
  %inc61 = add nsw i32 %31, 1, !dbg !132
  store i32 %inc61, i32* %i24, align 4, !dbg !132
  br label %for.cond25, !dbg !133, !llvm.loop !134

for.end62:                                        ; preds = %for.cond25
  call void @llvm.dbg.declare(metadata i32* %i63, metadata !136, metadata !DIExpression()), !dbg !138
  store i32 0, i32* %i63, align 4, !dbg !138
  br label %for.cond64, !dbg !139

for.cond64:                                       ; preds = %for.inc125, %for.end62
  %32 = load i32, i32* %i63, align 4, !dbg !140
  %cmp65 = icmp slt i32 %32, 2, !dbg !142
  br i1 %cmp65, label %for.body66, label %for.end127, !dbg !143

for.body66:                                       ; preds = %for.cond64
  call void @llvm.dbg.declare(metadata i32* %j67, metadata !144, metadata !DIExpression()), !dbg !147
  store i32 0, i32* %j67, align 4, !dbg !147
  br label %for.cond68, !dbg !148

for.cond68:                                       ; preds = %for.inc122, %for.body66
  %33 = load i32, i32* %j67, align 4, !dbg !149
  %cmp69 = icmp slt i32 %33, 3, !dbg !151
  br i1 %cmp69, label %for.body70, label %for.end124, !dbg !152

for.body70:                                       ; preds = %for.cond68
  call void @llvm.dbg.declare(metadata i32* %k71, metadata !153, metadata !DIExpression()), !dbg !156
  store i32 0, i32* %k71, align 4, !dbg !156
  br label %for.cond72, !dbg !157

for.cond72:                                       ; preds = %for.inc119, %for.body70
  %34 = load i32, i32* %k71, align 4, !dbg !158
  %cmp73 = icmp slt i32 %34, 4, !dbg !160
  br i1 %cmp73, label %for.body74, label %for.end121, !dbg !161

for.body74:                                       ; preds = %for.cond72
  %35 = load i32, i32* %i63, align 4, !dbg !162
  %idxprom75 = sext i32 %35 to i64, !dbg !164
  %arrayidx76 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom75, !dbg !164
  %36 = load i32, i32* %j67, align 4, !dbg !165
  %idxprom77 = sext i32 %36 to i64, !dbg !164
  %arrayidx78 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx76, i64 0, i64 %idxprom77, !dbg !164
  %37 = load i32, i32* %k71, align 4, !dbg !166
  %idxprom79 = sext i32 %37 to i64, !dbg !164
  %arrayidx80 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx78, i64 0, i64 %idxprom79, !dbg !164
  %38 = load i32, i32* %arrayidx80, align 4, !dbg !164
  %39 = load i32, i32* %i63, align 4, !dbg !167
  %idxprom81 = sext i32 %39 to i64, !dbg !168
  %arrayidx82 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom81, !dbg !168
  %40 = load i32, i32* %j67, align 4, !dbg !169
  %idxprom83 = sext i32 %40 to i64, !dbg !168
  %arrayidx84 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx82, i64 0, i64 %idxprom83, !dbg !168
  %41 = load i32, i32* %k71, align 4, !dbg !170
  %idxprom85 = sext i32 %41 to i64, !dbg !168
  %arrayidx86 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx84, i64 0, i64 %idxprom85, !dbg !168
  %42 = load i32, i32* %arrayidx86, align 4, !dbg !168
  %cmp87 = icmp eq i32 %38, %42, !dbg !171
  %conv = zext i1 %cmp87 to i32, !dbg !171
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !172
  %43 = load i32, i32* %i63, align 4, !dbg !173
  %idxprom88 = sext i32 %43 to i64, !dbg !174
  %arrayidx89 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom88, !dbg !174
  %44 = load i32, i32* %j67, align 4, !dbg !175
  %idxprom90 = sext i32 %44 to i64, !dbg !174
  %arrayidx91 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx89, i64 0, i64 %idxprom90, !dbg !174
  %45 = load i32, i32* %k71, align 4, !dbg !176
  %idxprom92 = sext i32 %45 to i64, !dbg !174
  %arrayidx93 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx91, i64 0, i64 %idxprom92, !dbg !174
  %46 = load i32, i32* %arrayidx93, align 4, !dbg !174
  %47 = load i32, i32* %i63, align 4, !dbg !177
  %idxprom94 = sext i32 %47 to i64, !dbg !178
  %arrayidx95 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr1, i64 0, i64 %idxprom94, !dbg !178
  %48 = load i32, i32* %j67, align 4, !dbg !179
  %idxprom96 = sext i32 %48 to i64, !dbg !178
  %arrayidx97 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx95, i64 0, i64 %idxprom96, !dbg !178
  %49 = load i32, i32* %k71, align 4, !dbg !180
  %idxprom98 = sext i32 %49 to i64, !dbg !178
  %arrayidx99 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx97, i64 0, i64 %idxprom98, !dbg !178
  %50 = load i32, i32* %arrayidx99, align 4, !dbg !178
  %mul = mul i32 2, %50, !dbg !181
  %cmp100 = icmp eq i32 %46, %mul, !dbg !182
  %conv101 = zext i1 %cmp100 to i32, !dbg !182
  %call102 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv101), !dbg !183
  %51 = load i32, i32* %i63, align 4, !dbg !184
  %idxprom103 = sext i32 %51 to i64, !dbg !185
  %arrayidx104 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr3, i64 0, i64 %idxprom103, !dbg !185
  %52 = load i32, i32* %j67, align 4, !dbg !186
  %idxprom105 = sext i32 %52 to i64, !dbg !185
  %arrayidx106 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx104, i64 0, i64 %idxprom105, !dbg !185
  %53 = load i32, i32* %k71, align 4, !dbg !187
  %idxprom107 = sext i32 %53 to i64, !dbg !185
  %arrayidx108 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx106, i64 0, i64 %idxprom107, !dbg !185
  %54 = load i32, i32* %arrayidx108, align 4, !dbg !185
  %55 = load i32, i32* %i63, align 4, !dbg !188
  %idxprom109 = sext i32 %55 to i64, !dbg !189
  %arrayidx110 = getelementptr inbounds [2 x [3 x [4 x i32]]], [2 x [3 x [4 x i32]]]* %arr2, i64 0, i64 %idxprom109, !dbg !189
  %56 = load i32, i32* %j67, align 4, !dbg !190
  %idxprom111 = sext i32 %56 to i64, !dbg !189
  %arrayidx112 = getelementptr inbounds [3 x [4 x i32]], [3 x [4 x i32]]* %arrayidx110, i64 0, i64 %idxprom111, !dbg !189
  %57 = load i32, i32* %k71, align 4, !dbg !191
  %idxprom113 = sext i32 %57 to i64, !dbg !189
  %arrayidx114 = getelementptr inbounds [4 x i32], [4 x i32]* %arrayidx112, i64 0, i64 %idxprom113, !dbg !189
  %58 = load i32, i32* %arrayidx114, align 4, !dbg !189
  %mul115 = mul i32 2, %58, !dbg !192
  %cmp116 = icmp eq i32 %54, %mul115, !dbg !193
  %conv117 = zext i1 %cmp116 to i32, !dbg !193
  %call118 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv117), !dbg !194
  br label %for.inc119, !dbg !195

for.inc119:                                       ; preds = %for.body74
  %59 = load i32, i32* %k71, align 4, !dbg !196
  %inc120 = add nsw i32 %59, 1, !dbg !196
  store i32 %inc120, i32* %k71, align 4, !dbg !196
  br label %for.cond72, !dbg !197, !llvm.loop !198

for.end121:                                       ; preds = %for.cond72
  br label %for.inc122, !dbg !200

for.inc122:                                       ; preds = %for.end121
  %60 = load i32, i32* %j67, align 4, !dbg !201
  %inc123 = add nsw i32 %60, 1, !dbg !201
  store i32 %inc123, i32* %j67, align 4, !dbg !201
  br label %for.cond68, !dbg !202, !llvm.loop !203

for.end124:                                       ; preds = %for.cond68
  br label %for.inc125, !dbg !205

for.inc125:                                       ; preds = %for.end124
  %61 = load i32, i32* %i63, align 4, !dbg !206
  %inc126 = add nsw i32 %61, 1, !dbg !206
  store i32 %inc126, i32* %i63, align 4, !dbg !206
  br label %for.cond64, !dbg !207, !llvm.loop !208

for.end127:                                       ; preds = %for.cond64
  ret i32 0, !dbg !210
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression/3d_array2")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "arr1", scope: !7, file: !1, line: 6, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !13, size: 768, elements: !14)
!13 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!14 = !{!15, !16, !17}
!15 = !DISubrange(count: 2)
!16 = !DISubrange(count: 3)
!17 = !DISubrange(count: 4)
!18 = !DILocation(line: 6, column: 11, scope: !7)
!19 = !DILocalVariable(name: "arr2", scope: !7, file: !1, line: 7, type: !12)
!20 = !DILocation(line: 7, column: 11, scope: !7)
!21 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 9, type: !13)
!22 = !DILocation(line: 9, column: 11, scope: !7)
!23 = !DILocalVariable(name: "i", scope: !24, file: !1, line: 10, type: !10)
!24 = distinct !DILexicalBlock(scope: !7, file: !1, line: 10, column: 2)
!25 = !DILocation(line: 10, column: 10, scope: !24)
!26 = !DILocation(line: 10, column: 6, scope: !24)
!27 = !DILocation(line: 10, column: 16, scope: !28)
!28 = distinct !DILexicalBlock(scope: !24, file: !1, line: 10, column: 2)
!29 = !DILocation(line: 10, column: 17, scope: !28)
!30 = !DILocation(line: 10, column: 2, scope: !24)
!31 = !DILocalVariable(name: "j", scope: !32, file: !1, line: 12, type: !10)
!32 = distinct !DILexicalBlock(scope: !33, file: !1, line: 12, column: 3)
!33 = distinct !DILexicalBlock(scope: !28, file: !1, line: 11, column: 2)
!34 = !DILocation(line: 12, column: 11, scope: !32)
!35 = !DILocation(line: 12, column: 7, scope: !32)
!36 = !DILocation(line: 12, column: 17, scope: !37)
!37 = distinct !DILexicalBlock(scope: !32, file: !1, line: 12, column: 3)
!38 = !DILocation(line: 12, column: 18, scope: !37)
!39 = !DILocation(line: 12, column: 3, scope: !32)
!40 = !DILocalVariable(name: "k", scope: !41, file: !1, line: 14, type: !10)
!41 = distinct !DILexicalBlock(scope: !42, file: !1, line: 14, column: 7)
!42 = distinct !DILexicalBlock(scope: !37, file: !1, line: 13, column: 3)
!43 = !DILocation(line: 14, column: 15, scope: !41)
!44 = !DILocation(line: 14, column: 11, scope: !41)
!45 = !DILocation(line: 14, column: 22, scope: !46)
!46 = distinct !DILexicalBlock(scope: !41, file: !1, line: 14, column: 7)
!47 = !DILocation(line: 14, column: 24, scope: !46)
!48 = !DILocation(line: 14, column: 7, scope: !41)
!49 = !DILocation(line: 16, column: 22, scope: !50)
!50 = distinct !DILexicalBlock(scope: !46, file: !1, line: 15, column: 7)
!51 = !DILocation(line: 16, column: 13, scope: !50)
!52 = !DILocation(line: 16, column: 8, scope: !50)
!53 = !DILocation(line: 16, column: 16, scope: !50)
!54 = !DILocation(line: 16, column: 19, scope: !50)
!55 = !DILocation(line: 16, column: 21, scope: !50)
!56 = !DILocation(line: 17, column: 22, scope: !50)
!57 = !DILocation(line: 17, column: 13, scope: !50)
!58 = !DILocation(line: 17, column: 8, scope: !50)
!59 = !DILocation(line: 17, column: 16, scope: !50)
!60 = !DILocation(line: 17, column: 19, scope: !50)
!61 = !DILocation(line: 17, column: 21, scope: !50)
!62 = !DILocation(line: 18, column: 9, scope: !50)
!63 = !DILocation(line: 19, column: 7, scope: !50)
!64 = !DILocation(line: 14, column: 31, scope: !46)
!65 = !DILocation(line: 14, column: 7, scope: !46)
!66 = distinct !{!66, !48, !67}
!67 = !DILocation(line: 19, column: 7, scope: !41)
!68 = !DILocation(line: 20, column: 3, scope: !42)
!69 = !DILocation(line: 12, column: 25, scope: !37)
!70 = !DILocation(line: 12, column: 3, scope: !37)
!71 = distinct !{!71, !39, !72}
!72 = !DILocation(line: 20, column: 3, scope: !32)
!73 = !DILocation(line: 21, column: 2, scope: !33)
!74 = !DILocation(line: 10, column: 24, scope: !28)
!75 = !DILocation(line: 10, column: 2, scope: !28)
!76 = distinct !{!76, !30, !77}
!77 = !DILocation(line: 21, column: 2, scope: !24)
!78 = !DILocalVariable(name: "arr3", scope: !7, file: !1, line: 23, type: !12)
!79 = !DILocation(line: 23, column: 11, scope: !7)
!80 = !DILocalVariable(name: "i", scope: !81, file: !1, line: 27, type: !10)
!81 = distinct !DILexicalBlock(scope: !7, file: !1, line: 27, column: 2)
!82 = !DILocation(line: 27, column: 10, scope: !81)
!83 = !DILocation(line: 27, column: 6, scope: !81)
!84 = !DILocation(line: 27, column: 16, scope: !85)
!85 = distinct !DILexicalBlock(scope: !81, file: !1, line: 27, column: 2)
!86 = !DILocation(line: 27, column: 17, scope: !85)
!87 = !DILocation(line: 27, column: 2, scope: !81)
!88 = !DILocalVariable(name: "j", scope: !89, file: !1, line: 29, type: !10)
!89 = distinct !DILexicalBlock(scope: !90, file: !1, line: 29, column: 3)
!90 = distinct !DILexicalBlock(scope: !85, file: !1, line: 28, column: 2)
!91 = !DILocation(line: 29, column: 11, scope: !89)
!92 = !DILocation(line: 29, column: 7, scope: !89)
!93 = !DILocation(line: 29, column: 17, scope: !94)
!94 = distinct !DILexicalBlock(scope: !89, file: !1, line: 29, column: 3)
!95 = !DILocation(line: 29, column: 18, scope: !94)
!96 = !DILocation(line: 29, column: 3, scope: !89)
!97 = !DILocalVariable(name: "k", scope: !98, file: !1, line: 31, type: !10)
!98 = distinct !DILexicalBlock(scope: !99, file: !1, line: 31, column: 7)
!99 = distinct !DILexicalBlock(scope: !94, file: !1, line: 30, column: 3)
!100 = !DILocation(line: 31, column: 15, scope: !98)
!101 = !DILocation(line: 31, column: 11, scope: !98)
!102 = !DILocation(line: 31, column: 22, scope: !103)
!103 = distinct !DILexicalBlock(scope: !98, file: !1, line: 31, column: 7)
!104 = !DILocation(line: 31, column: 24, scope: !103)
!105 = !DILocation(line: 31, column: 7, scope: !98)
!106 = !DILocation(line: 33, column: 29, scope: !107)
!107 = distinct !DILexicalBlock(scope: !103, file: !1, line: 32, column: 7)
!108 = !DILocation(line: 33, column: 24, scope: !107)
!109 = !DILocation(line: 33, column: 32, scope: !107)
!110 = !DILocation(line: 33, column: 35, scope: !107)
!111 = !DILocation(line: 33, column: 45, scope: !107)
!112 = !DILocation(line: 33, column: 40, scope: !107)
!113 = !DILocation(line: 33, column: 48, scope: !107)
!114 = !DILocation(line: 33, column: 51, scope: !107)
!115 = !DILocation(line: 33, column: 38, scope: !107)
!116 = !DILocation(line: 33, column: 13, scope: !107)
!117 = !DILocation(line: 33, column: 8, scope: !107)
!118 = !DILocation(line: 33, column: 16, scope: !107)
!119 = !DILocation(line: 33, column: 19, scope: !107)
!120 = !DILocation(line: 33, column: 22, scope: !107)
!121 = !DILocation(line: 34, column: 7, scope: !107)
!122 = !DILocation(line: 31, column: 31, scope: !103)
!123 = !DILocation(line: 31, column: 7, scope: !103)
!124 = distinct !{!124, !105, !125}
!125 = !DILocation(line: 34, column: 7, scope: !98)
!126 = !DILocation(line: 35, column: 3, scope: !99)
!127 = !DILocation(line: 29, column: 25, scope: !94)
!128 = !DILocation(line: 29, column: 3, scope: !94)
!129 = distinct !{!129, !96, !130}
!130 = !DILocation(line: 35, column: 3, scope: !89)
!131 = !DILocation(line: 36, column: 2, scope: !90)
!132 = !DILocation(line: 27, column: 24, scope: !85)
!133 = !DILocation(line: 27, column: 2, scope: !85)
!134 = distinct !{!134, !87, !135}
!135 = !DILocation(line: 36, column: 2, scope: !81)
!136 = !DILocalVariable(name: "i", scope: !137, file: !1, line: 39, type: !10)
!137 = distinct !DILexicalBlock(scope: !7, file: !1, line: 39, column: 2)
!138 = !DILocation(line: 39, column: 10, scope: !137)
!139 = !DILocation(line: 39, column: 6, scope: !137)
!140 = !DILocation(line: 39, column: 15, scope: !141)
!141 = distinct !DILexicalBlock(scope: !137, file: !1, line: 39, column: 2)
!142 = !DILocation(line: 39, column: 16, scope: !141)
!143 = !DILocation(line: 39, column: 2, scope: !137)
!144 = !DILocalVariable(name: "j", scope: !145, file: !1, line: 41, type: !10)
!145 = distinct !DILexicalBlock(scope: !146, file: !1, line: 41, column: 3)
!146 = distinct !DILexicalBlock(scope: !141, file: !1, line: 40, column: 2)
!147 = !DILocation(line: 41, column: 11, scope: !145)
!148 = !DILocation(line: 41, column: 7, scope: !145)
!149 = !DILocation(line: 41, column: 17, scope: !150)
!150 = distinct !DILexicalBlock(scope: !145, file: !1, line: 41, column: 3)
!151 = !DILocation(line: 41, column: 18, scope: !150)
!152 = !DILocation(line: 41, column: 3, scope: !145)
!153 = !DILocalVariable(name: "k", scope: !154, file: !1, line: 43, type: !10)
!154 = distinct !DILexicalBlock(scope: !155, file: !1, line: 43, column: 7)
!155 = distinct !DILexicalBlock(scope: !150, file: !1, line: 42, column: 3)
!156 = !DILocation(line: 43, column: 15, scope: !154)
!157 = !DILocation(line: 43, column: 11, scope: !154)
!158 = !DILocation(line: 43, column: 22, scope: !159)
!159 = distinct !DILexicalBlock(scope: !154, file: !1, line: 43, column: 7)
!160 = !DILocation(line: 43, column: 24, scope: !159)
!161 = !DILocation(line: 43, column: 7, scope: !154)
!162 = !DILocation(line: 45, column: 23, scope: !163)
!163 = distinct !DILexicalBlock(scope: !159, file: !1, line: 44, column: 7)
!164 = !DILocation(line: 45, column: 18, scope: !163)
!165 = !DILocation(line: 45, column: 26, scope: !163)
!166 = !DILocation(line: 45, column: 29, scope: !163)
!167 = !DILocation(line: 45, column: 40, scope: !163)
!168 = !DILocation(line: 45, column: 35, scope: !163)
!169 = !DILocation(line: 45, column: 43, scope: !163)
!170 = !DILocation(line: 45, column: 46, scope: !163)
!171 = !DILocation(line: 45, column: 32, scope: !163)
!172 = !DILocation(line: 45, column: 11, scope: !163)
!173 = !DILocation(line: 46, column: 20, scope: !163)
!174 = !DILocation(line: 46, column: 15, scope: !163)
!175 = !DILocation(line: 46, column: 23, scope: !163)
!176 = !DILocation(line: 46, column: 26, scope: !163)
!177 = !DILocation(line: 46, column: 39, scope: !163)
!178 = !DILocation(line: 46, column: 34, scope: !163)
!179 = !DILocation(line: 46, column: 42, scope: !163)
!180 = !DILocation(line: 46, column: 45, scope: !163)
!181 = !DILocation(line: 46, column: 33, scope: !163)
!182 = !DILocation(line: 46, column: 29, scope: !163)
!183 = !DILocation(line: 46, column: 8, scope: !163)
!184 = !DILocation(line: 47, column: 20, scope: !163)
!185 = !DILocation(line: 47, column: 15, scope: !163)
!186 = !DILocation(line: 47, column: 23, scope: !163)
!187 = !DILocation(line: 47, column: 26, scope: !163)
!188 = !DILocation(line: 47, column: 39, scope: !163)
!189 = !DILocation(line: 47, column: 34, scope: !163)
!190 = !DILocation(line: 47, column: 42, scope: !163)
!191 = !DILocation(line: 47, column: 45, scope: !163)
!192 = !DILocation(line: 47, column: 33, scope: !163)
!193 = !DILocation(line: 47, column: 29, scope: !163)
!194 = !DILocation(line: 47, column: 8, scope: !163)
!195 = !DILocation(line: 48, column: 7, scope: !163)
!196 = !DILocation(line: 43, column: 31, scope: !159)
!197 = !DILocation(line: 43, column: 7, scope: !159)
!198 = distinct !{!198, !161, !199}
!199 = !DILocation(line: 48, column: 7, scope: !154)
!200 = !DILocation(line: 49, column: 3, scope: !155)
!201 = !DILocation(line: 41, column: 25, scope: !150)
!202 = !DILocation(line: 41, column: 3, scope: !150)
!203 = distinct !{!203, !152, !204}
!204 = !DILocation(line: 49, column: 3, scope: !145)
!205 = !DILocation(line: 50, column: 2, scope: !146)
!206 = !DILocation(line: 39, column: 22, scope: !141)
!207 = !DILocation(line: 39, column: 2, scope: !141)
!208 = distinct !{!208, !143, !209}
!209 = !DILocation(line: 50, column: 2, scope: !137)
!210 = !DILocation(line: 52, column: 2, scope: !7)
