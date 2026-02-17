def matrix_multiply(matrix_a, matrix_b):
    num_cols = len(matrix_a[0])
    num_rows = len(matrix_b)

    result_matrix = [[0 for _ in range(len(matrix_b[0]))] for _ in range(len(matrix_a))]
    if num_cols == num_rows:
        for row in range(len(matrix_a)):
            result = 0
            for col in range(len(matrix_b[0])):
                for k in range(len(matrix_a[0])):
                    result += matrix_a[row][k]*matrix_b[k][col]
                result_matrix[row][col] = result
    return result_matrix